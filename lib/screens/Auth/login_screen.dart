import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediclica/componnets/functions.dart';
import 'package:mediclica/componnets/show_toast.dart';
import 'package:mediclica/resources/color_manager.dart';
import 'package:mediclica/resources/values_manager.dart';
import 'package:mediclica/screens/Auth/bloc/cubit.dart';
import 'package:mediclica/screens/Auth/bloc/states.dart';
import 'package:mediclica/screens/Auth/signup_screen.dart';
import 'package:mediclica/screens/Layout/main_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../componnets/button_width.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final GlobalKey<FormState> formKey;
  @override
  void initState() {
    // TODO: implement initState
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = AuthCubit.get(context);
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(top: 25.h, left: 6.w, right: 6.w),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome Back",
                  style: TextStyle(
                      color: ColorManager.primary,
                      fontWeight: FontWeight.w700,
                      fontSize: 22.sp),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "We're excited to have you back, can't wait to see what you've"
                  " been up to since you last logged in",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: ColorManager.grey),
                ),
                SizedBox(
                  height: 6.h,
                ),
                TextFormField(
                  controller: cubit.loginEmailController,
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
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  controller: cubit.loginPasswordController,
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
                BlocConsumer<AuthCubit, AuthStates>(
                  listener: (context, state) {
                    if (state is LoginSucssesState) {
                      Functions.navigatorPushAndRemove(context, MainScreen());
                    }
                    if (state is LoginErrorState) {
                      showToast(message: "Incorrect Email Or Password");
                    }
                  },
                  builder: (context, state) {
                    return ConditionalBuilder(
                      condition: state is! LoginLoadingState,
                      builder: (context) => Row(
                        children: [
                          widthButton(
                            textButton: "Login",
                            onPress: () async {
                              await cubit.login(
                                  email: cubit.loginEmailController.text,
                                  password: cubit.loginPasswordController.text);
                            },
                          ),
                        ],
                      ),
                      fallback: (context) => Center(
                        child: CircularProgressIndicator(
                          color: ColorManager.primary,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 12.h,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     Container(
                //       width: 30.w,
                //       height: 0.1.h,
                //       color: ColorManager.grey,
                //     ),
                //     Text(
                //       "Or sign in with",
                //       style: TextStyle(color: ColorManager.grey),
                //     ),
                //     Container(
                //       width: 30.w,
                //       height: 0.1.h,
                //       color: ColorManager.grey,
                //     ),
                //   ],
                // ),
                // SizedBox(
                //   height: 3.h,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Container(
                //       child: IconButton(
                //           onPressed: () {},
                //           icon: Image.asset(
                //             "assets/FaceBook.png",
                //           )),
                //       width: 12.w,
                //       height: 6.h,
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(20.w),
                //         color: Color(0x11A9B2B9),
                //       ),
                //     ),
                //     SizedBox(
                //       width: 5.w,
                //     ),
                //     Container(
                //       child: IconButton(
                //           onPressed: () {},
                //           icon: Image.asset(
                //             "assets/Gmail.png",
                //           )),
                //       width: 12.w,
                //       height: 6.h,
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(20.w),
                //         color: Color(0x11A9B2B9),
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(
                //   height: 3.h,
                // ),
                Text(
                  "By logging, you agree to our  Terms & Conditions and ",
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
                        fontSize: AppSize.s15,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account yet?",
                      style: TextStyle(fontSize: AppSize.s16),
                    ),
                    TextButton(
                        onPressed: () {
                          Functions.navigatorPush(context, SignUpScreen());
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(fontSize: AppSize.s16),
                        )),
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
