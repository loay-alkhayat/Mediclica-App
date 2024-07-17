import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediclica/componnets/button_width.dart';
import 'package:mediclica/resources/color_manager.dart';
import 'package:mediclica/screens/Auth/bloc/cubit.dart';
import 'package:mediclica/screens/Auth/bloc/states.dart';
import 'package:mediclica/screens/Layout/main_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../componnets/functions.dart';

class UserInformatioScreen extends StatelessWidget {
  UserInformatioScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = AuthCubit.get(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 22.h, left: 6.w, right: 6.w),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Fill Your Profile",
                  style: TextStyle(
                      color: ColorManager.primary,
                      fontWeight: FontWeight.w700,
                      fontSize: 22.sp),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "Please take a few minutes to fill out your profile with as much detail as possible.",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 17.sp,
                    color: ColorManager.grey,
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                TextFormField(
                  controller: cubit.firstname,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Your FirstName ';
                    } else if (RegExp(r'\d').hasMatch(value)) {
                      return 'Name must not contain numbers';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2.w)),
                    label: Text("First Name"),
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: cubit.lastname,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Your LastName ';
                    } else if (RegExp(r'\d').hasMatch(value)) {
                      return ' Must not contain numbers';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2.w)),
                    label: Text("Last Name"),
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                TextFormField(
                  keyboardType: TextInputType.numberWithOptions(decimal: false),
                  textInputAction: TextInputAction.done,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  controller: cubit.phonenumber,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a PhoneNumber';
                    } else if (value.length != 10) {
                      return 'Number must be 10 digits ';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2.w)),
                    label: Text("Phone Number"),
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BlocConsumer<AuthCubit, AuthStates>(
                      listener: (context, state) {
                        if (state is RegisterSucssesState) {
                          return Functions.navigatorPushAndRemove(
                              context, MainScreen());
                        }
                      },
                      builder: (context, state) {
                        return ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (context) => widthButton(
                            textButton: "Submit",
                            onPress: () async {
                              if (formKey.currentState!.validate()) {
                                await cubit.register(
                                  email: cubit.emailController.text,
                                  firstname: cubit.firstname.text,
                                  lastname: cubit.lastname.text,
                                  phone: cubit.phonenumber.text,
                                  password: cubit.passwordController.text,
                                  confirmPassword:
                                      cubit.repasswordController.text,
                                );
                              }
                            },
                          ),
                          fallback: (context) => Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
