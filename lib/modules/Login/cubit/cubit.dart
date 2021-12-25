import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_am/model/login_model.dart';
import 'package:shop_app_am/modules/Login/cubit/states.dart';
import 'package:shop_app_am/shared/network/remote/dio_helper.dart';
import 'package:shop_app_am/shared/network/remote/end_point.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);
  ShopLoginModel loginModel ;
  void userLogin({
  @required String email,
  @required String password,
}) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'to':email,
        'password':password,
      },
    ).then((value) {
      print(value.data);
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error){
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }
  IconData suffix= Icons.visibility_outlined;
  bool isPasswordShown=true;
  void changePasswordVisibility(){
    isPasswordShown = !isPasswordShown;
    suffix= isPasswordShown ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopLoginPasswordVisibilityState());
  }
}
