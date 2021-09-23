import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_am/layout/shop_layout.dart';
import 'package:shop_app_am/shared/components/components.dart';
import 'package:shop_app_am/shared/components/constants.dart';
import 'package:shop_app_am/shared/network/local/cache_helper.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ShopRegisterScreen extends StatelessWidget {
  var nameController =TextEditingController();
  var emailController =TextEditingController();
  var passwordController =TextEditingController();
  var phoneController =TextEditingController();
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer< ShopRegisterCubit , ShopRegisterStates>(
       listener: (context,state){
         if(state is ShopRegisterSuccessState){
           if(state.registerModel.status){
             print(state.registerModel.message);
             print(state.registerModel.data.token);
             CacheHelper.saveData(key: 'token', value: state.registerModel.data.token).then((value) {
               token =state.registerModel.data.token ;
               navigateAndFinish(context, ShopLayout());
             });
           } else{
             print(state.registerModel.message);
             showToast(text: state.registerModel.message, state: ToastState.ERROR);
           }
         }
       },
       builder: (context,state){
         return Scaffold(
             appBar: AppBar(),
             body: Center(
               child: SingleChildScrollView(
                 child: Padding(
                   padding: const EdgeInsets.all(20.0),
                   child: Form(
                     key: formKey,
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(
                           'Register',
                           style: Theme.of(context)
                               .textTheme
                               .headline4
                               .copyWith(color: Colors.black),
                         ),
                         Text(
                           'Register now to browse our hot offer',
                           style: Theme.of(context)
                               .textTheme
                               .bodyText1
                               .copyWith(color: Colors.grey),
                         ),
                         SizedBox(
                           height: 14,
                         ),
                         defaultFormFiled(
                           controller: nameController,
                           type: TextInputType.text,
                           label: 'User Name',
                           prefix: Icons.person,
                           validate: (String value) {
                             if (value.isEmpty) {
                               return 'enter your name';
                             } else {
                               return null;
                             }
                           },
                         ),
                         SizedBox(
                           height: 14,
                         ),
                         defaultFormFiled(
                           controller: phoneController,
                           type: TextInputType.phone,
                           label: 'Phone Number',
                           prefix: Icons.phone,
                           validate: (String value) {
                             if (value.isEmpty) {
                               return 'enter your phone number';
                             } else {
                               return null;
                             }
                           },
                         ),
                         SizedBox(
                           height: 14,
                         ),
                         defaultFormFiled(
                           controller: emailController,
                           type: TextInputType.emailAddress,
                           label: 'E-mail Address',
                           prefix: Icons.email_outlined,
                           validate: (String value) {
                             if (value.isEmpty) {
                               return 'enter your email address';
                             } else {
                               return null;
                             }
                           },
                         ),
                         SizedBox(
                           height: 14,
                         ),
                         defaultFormFiled(
                           controller: passwordController,
                           type: TextInputType.visiblePassword,
                           label: 'Password',
                           isPassword: ShopRegisterCubit.get(context).isPasswordShown,

                           onSubmit: (value) {

                           },
                           suffix:  ShopRegisterCubit.get(context).suffix,
                           suffixPressed: () {
                             ShopRegisterCubit.get(context).changePasswordVisibility();
                           },
                           prefix: Icons.lock,
                           validate: (String value) {
                             if (value.isEmpty) {
                               return 'password is too short';
                             } else {
                               return null;
                             }
                           },
                         ),
                         SizedBox(
                           height: 30,
                         ),
                         ConditionalBuilder(
                           condition: state is! ShopRegisterLoadingState,
                           builder: (context) {
                             return defaultButtom(
                                 function: () {
                                   if(formKey.currentState.validate()){
                                     ShopRegisterCubit.get(context).userRegister(
                                         email: emailController.text,
                                         name: nameController.text,
                                         phone: phoneController.text,
                                         password: passwordController.text,
                                     );
                                   }
                                 }, text: 'Register', isupperCase: true);
                           },
                           fallback: (context) => Center(child: CircularProgressIndicator()
                           ),),
                         SizedBox(
                           height: 15,
                         ),
                       ],
                     ),
                   ),
                 ),
               ),
             ),
         );
       },
      ),
    );
  }
}
