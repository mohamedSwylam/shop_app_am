import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_am/layout/cubit/cubit.dart';
import 'package:shop_app_am/layout/cubit/states.dart';
import 'package:shop_app_am/shared/components/components.dart';
import 'package:shop_app_am/shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var model = ShopCubit.get(context).userLoginModel;
          nameController.text = model.data.name;
          emailController.text = model.data.email;
          phoneController.text = model.data.phone;
          return ConditionalBuilder(
            condition: ShopCubit.get(context).userLoginModel != null,
            builder: (context) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey ,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if(state is  ShopUpdateUserDataLoadingState)
                      LinearProgressIndicator(),
                      SizedBox(
                        height: 20,
                      ),
                      defaultFormFiled(
                          controller: nameController,
                          type: TextInputType.text,
                          label: 'User Name',
                          prefix: Icons.person,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'user name must not be empty';
                            } else {
                              return null;
                            }
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      defaultFormFiled(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          label: 'E-mail Address',
                          prefix: Icons.email,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'E-mail address must not be empty';
                            } else {
                              return null;
                            }
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      defaultFormFiled(
                          controller: phoneController,
                          type: TextInputType.phone,
                          label: 'Phone Number',
                          prefix: Icons.phone,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'phone number must not be empty';
                            } else {
                              return null;
                            }
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      defaultButtom(
                          function: () {
                            if(formKey.currentState.validate()){  ShopCubit.get(context).updateUserData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                            );
                            }
                          },
                          text: 'Update'),
                      SizedBox(
                        height: 20,
                      ),
                      defaultButtom(
                          function: () => signOut(context), text: 'Logout'),
                    ],
                  ),
                ),
              ),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        });
  }
}
