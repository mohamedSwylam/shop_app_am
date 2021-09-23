import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_am/layout/cubit/states.dart';
import 'package:shop_app_am/model/categories_model.dart';
import 'package:shop_app_am/model/change_favorites_model.dart';
import 'package:shop_app_am/model/favorites_model.dart';
import 'package:shop_app_am/model/home_model.dart';
import 'package:shop_app_am/model/login_model.dart';
import 'package:shop_app_am/modules/categories/categories_screen.dart';
import 'package:shop_app_am/modules/favorite/favorite_screen.dart';
import 'package:shop_app_am/modules/prouduct/product_screen.dart';
import 'package:shop_app_am/modules/settings/settings_screen.dart';
import 'package:shop_app_am/shared/components/constants.dart';
import 'package:shop_app_am/shared/network/local/cache_helper.dart';
import 'package:shop_app_am/shared/network/remote/dio_helper.dart';
import 'package:shop_app_am/shared/network/remote/end_point.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> shopScreens = [
    ProductScreen(),
    CategoriesScreen(),
    FavoriteScreen(),
    SettingsScreen(),
  ];
  bool isDark = false;

  void changeThemeMode({bool fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ShopAppChangeThemeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(ShopAppChangeThemeModeState());
      });
    }
  }
  void changeIndex(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel homeModel;
  Map<int, bool> favorite = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      /*printFullText(homeModel.data.banners[0].image);
      print(homeModel.status);*/
      homeModel.data.products.forEach((element) {
        favorite.addAll({element.id: element.inFavorites});
      });
      print(favorite.toString());
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel categoriesModel;

  void getCategoriesData() {
    DioHelper.getData(url: GET_CATEGORIES, token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      print(categoriesModel.status);
      emit(ShopSuccessCategoriesDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesDataState());
    });
  }

  ChangeFavoritesModel changeFavoritesModel;

  void changeFavorite(int productId) {
    favorite[productId] = !favorite[productId];
    emit(ShopChangeFavoritesState());
    DioHelper.postData(
      url: FAVORITES,
      token: token,
      data: {
        'product_id': productId,
      },
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if (!changeFavoritesModel.status) {
        favorite[productId] = !favorite[productId];
      } else {
        getFavorites();
      }
      print(value.data);
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel));
    }).catchError((error) {
      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavoritesModel favoritesModel;

  void getFavorites() {
    emit(ShopGetFavoritesLoadingState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      //printFullText(value.data.toString());

      emit(ShopGetFavoritesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }

  ShopLoginModel userLoginModel;

  void getUserData() {
    emit(ShopGetUserDataLoadingState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userLoginModel = ShopLoginModel.fromJson(value.data);
      //printFullText(value.data.toString());

      emit(ShopGetUserDataSuccessState(userLoginModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetUserDataState());
    });
  }

  void updateUserData({
    @required String name,
    @required String email,
    @required String phone,
  }) {
    emit(ShopUpdateUserDataLoadingState());
    DioHelper.putData(url: UPDATE_PROFILE, token: token, data: {
      'name': name,
      'email': email,
      'phone': phone,
    })
        .then((value) {
      userLoginModel = ShopLoginModel.fromJson(value.data);
      //printFullText(value.data.toString());

      emit(ShopUpdateUserDataSuccessState(userLoginModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserDataState());
    });
  }
}
