import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediclica/componnets/button_width.dart';
import 'package:mediclica/componnets/show_toast.dart';
import 'package:mediclica/core/services/media_sevices.dart';
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
    MediaService mediaService = MediaService();

    return BlocConsumer<AuthCubit, AuthStates>(
      builder: (context, state) => Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 7.h, left: 6.w, right: 6.w),
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
                  Center(
                    child:
                        Stack(alignment: Alignment(0.35.w, 0.15.h), children: [
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: cubit.selectedImage == null
                            ? Image.asset(
                                "assets/person_image"
                                ".png",
                                fit: BoxFit.contain)
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(20.w),
                                child: Image.file(
                                  cubit.selectedImage!,
                                  width: 40.w,
                                )),
                        radius: 15.w,
                      ),
                      IconButton(
                        onPressed: () async {
                          File? selectedImage =
                              await mediaService.getImage(fromGallery: true);
                          cubit.setSelectedImage(selectedImage);
                        },
                        icon: Image.asset(
                          "assets/Change_Profile_Icon.png",
                          fit: BoxFit.contain,
                        ),
                      )
                    ]),
                  ),
                  SizedBox(
                    height: 3.h,
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
                  // TextFormField(
                  //   validator: (value) {
                  //     if (value!.length < 9) return "الرجاء كتابة الرقم بالكامل";
                  //   },
                  //   maxLength: 9,
                  //   controller: phoneNumberController,
                  //   autofocus: false,
                  //   cursorHeight: 25,
                  //   keyboardType: TextInputType.numberWithOptions(decimal: false),
                  //   style: TextStyle(
                  //     fontSize: 18,
                  //   ),
                  //   decoration: InputDecoration(
                  //     border: OutlineInputBorder(
                  //         borderSide: BorderSide(color: Colors.red)),
                  //     errorStyle: TextStyle(color: Colors.red),
                  //     errorBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(color: Colors.red),
                  //         borderRadius: BorderRadius.circular(10)),
                  //     hintText: "9xx xxx xxx",
                  //     prefixIcon: Container(
                  //       width: 20.w,
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.start,
                  //         children: [
                  //           Padding(
                  //             padding: EdgeInsets.only(left: 8, bottom: 5),
                  //             child: Text(
                  //               "(+963)",
                  //               style: TextStyle(
                  //                 fontSize: 18,
                  //               ),
                  //             ),
                  //           ),
                  //           SizedBox(
                  //             width: 1.w,
                  //           ),
                  //           SizedBox(
                  //             height: 3.h,
                  //             child: Container(
                  //               width: 0.5,
                  //               color: Colors.grey,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     enabledBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(color: Colors.black),
                  //         borderRadius: BorderRadius.circular(10)),
                  //     focusedBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(10)),
                  //   ),
                  // ),
                  TextFormField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: false),
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
                    height: 1.h,
                  ),
                  Row(
                    children: [
                      Text(
                        "Date:",
                        style: TextStyle(fontSize: 18.sp),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Text(
                        "${cubit.userBirthday}",
                        style: TextStyle(color: ColorManager.grey),
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime.now(),
                          );
                          if (pickedDate != null) {
                            cubit.setBirthday(pickedDate);
                          }
                        },
                        child: Text(
                          'Choose Birthday',
                          style: TextStyle(color: ColorManager.primary),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                        activeColor: ColorManager.primary,
                        value: "male",
                        groupValue: cubit.gender,
                        onChanged: (value) {
                          return cubit.CheckGender(value);
                        },
                      ),
                      Text(
                        "Male",
                        style: TextStyle(fontSize: 17.sp),
                      ),
                      Icon(Icons.man),
                      SizedBox(
                        width: 1.w,
                      ),
                      Text(
                        "|",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 1.w,
                      ),
                      Icon(Icons.woman),
                      Text(
                        "female",
                        style: TextStyle(fontSize: 17.sp),
                      ),
                      Radio(
                        activeColor: ColorManager.primary,
                        value: "female",
                        groupValue: cubit.gender,
                        onChanged: (value) {
                          return cubit.CheckGender(value);
                        },
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ConditionalBuilder(
                        condition: state is! RegisterLoadingState,
                        builder: (context) => widthButton(
                          textButton: "Submit",
                          onPress: () async {
                            if (cubit.gender == "") {
                              showToast(
                                  message: "Please Choose Your Gender",
                                  color: ColorManager.lightprimary,
                                  textColor: ColorManager.white);
                            } else if (cubit.selectBirhday != true) {
                              showToast(
                                  message: "Please Select Your "
                                      "Birthday",
                                  color: ColorManager.lightprimary,
                                  textColor: ColorManager.white);
                            } else {
                              if (formKey.currentState!.validate()) {
                                await cubit.register(
                                    email: cubit.emailController.text,
                                    firstname: cubit.firstname.text,
                                    gender: cubit.gender,
                                    lastname: cubit.lastname.text,
                                    phone: cubit.phonenumber.text,
                                    password: cubit.passwordController.text,
                                    confirmPassword:
                                        cubit.repasswordController.text,
                                    birthDay: cubit.userBirthday,
                                    userImage: cubit.selectedImage.toString());
                              }
                            }
                          },
                        ),
                        fallback: (context) => Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      listener: (context, state) {
        if (state is RegisterSucssesState) {
          return Functions.navigatorPushAndRemove(context, MainScreen());
        }
      },
    );
  }
}
