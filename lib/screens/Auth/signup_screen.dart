import 'package:flutter/material.dart';
import 'package:mediclica/componnets/button_width.dart';
import 'package:mediclica/resources/color_manager.dart';
import 'package:mediclica/screens/Auth/bloc/cubit.dart';
import 'package:mediclica/screens/Auth/user_information.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../componnets/functions.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = AuthCubit.get(context);
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(top: 15.h, left: 6.w, right: 6.w),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Create Account",
                  style: TextStyle(
                      color: ColorManager.primary,
                      fontWeight: FontWeight.w700,
                      fontSize: 22),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "Sign up now and start exploring all that our app has to offer."
                  " We're excited to welcome you to our community!",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 17,
                    color: ColorManager.grey,
                  ),
                ),
                SizedBox(
                  height: 6.h,
                ),
                TextFormField(
                  controller: cubit.emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email address';
                    } else if (!RegExp(
                            r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2.w)),
                    label: Text(
                      "E-mail",
                      style: TextStyle(color: ColorManager.grey),
                    ),
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  obscureText: true,
                  controller: cubit.passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    } else if (value.length < 8) {
                      return 'Password must be at least 8 characters long';
                    } else if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d).*$')
                        .hasMatch(value)) {
                      return 'Password must contain both letters and numbers';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2.w)),
                    label: Text(
                      "Password",
                      style: TextStyle(color: ColorManager.grey),
                    ),
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  controller: cubit.repasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a re-password';
                    } else if (value.length < 8) {
                      return 'Password must be at least 8 characters long';
                    } else if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d).*$')
                        .hasMatch(value)) {
                      return 'Password must contain both letters and numbers';
                    } else if (cubit.passwordController.text !=
                        cubit.repasswordController.text) {
                      return 'Not Same Password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2.w)),
                    label: Text(
                      "Re-Password",
                      style: TextStyle(color: ColorManager.grey),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  children: [
                    widthButton(
                      textButton: "Create Account",
                      onPress: () {
                        if (formKey.currentState!.validate()) {
                          Functions.navigatorPush(
                              context, UserInformatioScreen());
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 7.h,
                ),
                Text(
                  "By signUp, you agree to our  Terms & Conditions and ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.5.sp,
                    color: ColorManager.grey,
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Center(
                  child: InkWell(
                    onTap: () {},
                    child: Text(
                      "PrivacyPolicy.",
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: ColorManager.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
