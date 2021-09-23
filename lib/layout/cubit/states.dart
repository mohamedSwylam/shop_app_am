
import 'package:shop_app_am/model/change_favorites_model.dart';
import 'package:shop_app_am/model/login_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}

class ShopSuccessCategoriesDataState extends ShopStates {}

class ShopErrorCategoriesDataState extends ShopStates {}

class ShopSuccessChangeFavoritesState extends ShopStates {
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesState(this.model);
}

class ShopChangeFavoritesState extends ShopStates {}
class ShopAppChangeThemeModeState extends ShopStates {}

class ShopErrorChangeFavoritesState extends ShopStates {}

class ShopGetFavoritesLoadingState extends ShopStates {}

class ShopGetFavoritesSuccessState extends ShopStates {}

class ShopErrorGetFavoritesState extends ShopStates {}

class ShopGetUserDataLoadingState extends ShopStates {}

class ShopGetUserDataSuccessState extends ShopStates {
 final ShopLoginModel loginModel;

  ShopGetUserDataSuccessState(this.loginModel);
}

class ShopErrorGetUserDataState extends ShopStates {}
class ShopUpdateUserDataLoadingState extends ShopStates {}

class ShopUpdateUserDataSuccessState extends ShopStates {
  final ShopLoginModel loginModel;

  ShopUpdateUserDataSuccessState(this.loginModel);
}

class ShopErrorUpdateUserDataState extends ShopStates {}