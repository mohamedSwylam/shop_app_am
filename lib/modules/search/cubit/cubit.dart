
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_am/model/search_model.dart';
import 'package:shop_app_am/modules/search/cubit/states.dart';
import 'package:shop_app_am/shared/components/constants.dart';
import 'package:shop_app_am/shared/network/remote/dio_helper.dart';
import 'package:shop_app_am/shared/network/remote/end_point.dart';

class ShopSearchCubit extends Cubit<ShopSearchStates> {
  ShopSearchCubit() : super(SearchInitialState());

  static ShopSearchCubit get(context) => BlocProvider.of(context);
  SearchModel searchModel;

  void searchProduct({String text}) {
    emit(SearchLoadingState());
    DioHelper.postData(
      url: SEARCH_PRODUCT,
      token: token,
      data: {
        'text': text,
      },
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error) {
      emit(SearchErrorState());
    });
  }
}
