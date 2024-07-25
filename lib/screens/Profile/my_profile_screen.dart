import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediclica/componnets/functions.dart';
import 'package:mediclica/componnets/profile_info_card.dart';
import 'package:mediclica/core/services/cache_storage_services.dart';
import 'package:mediclica/resources/color_manager.dart';
import 'package:mediclica/screens/Auth/login_screen.dart';
import 'package:mediclica/screens/Layout/Bloc/cubit.dart';
import 'package:mediclica/screens/Layout/Bloc/states.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'edit_profile_sreen.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LayoutCubit cubit = LayoutCubit.get(context);
    return BlocConsumer<LayoutCubit, LayoutStates>(
      builder: (context, state) => SafeArea(
        child: Scaffold(
          backgroundColor: ColorManager.primary,
          body: OverlayLoaderWithAppIcon(
            isLoading: false,
            borderRadius: 90.w,
            appIconSize: 20.w,
            appIcon: Image.asset("assets/profile.png"),
            overlayBackgroundColor: ColorManager.lightGrey,
            circularProgressColor: ColorManager.grey,
            child: Stack(
              children: [
                Column(children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  Center(
                    child: Text(
                      "Profile",
                      style: TextStyle(
                          fontSize: 20.sp,
                          color: ColorManager.white,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(6.w),
                              topRight: Radius.circular(6.w))),
                    ),
                  ),
                ]),
                ConditionalBuilder(
                  condition: cubit.getProfileData,
                  builder: (context) => Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            ClipRRect(
                              child: CircleAvatar(
                                backgroundColor: ColorManager.white,
                                radius: 14.w,
                                child: Image.asset("assets/profile.png"),
                              ),
                              borderRadius: BorderRadius.circular(16.w),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                            ),

                            // InkWell(
                            //   onTap: () {},
                            //   overlayColor:
                            //       MaterialStatePropertyAll(ColorManager.grey2),
                            //   child: CircleAvatar(
                            //     backgroundColor: Colors.white,
                            //     radius: 5.w,
                            //     child: Container(
                            //       height: 4.h,
                            //       width: 8.w,
                            //       decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.all(
                            //           Radius.circular(10.w),
                            //         ),
                            //         color: ColorManager.grey2,
                            //       ),
                            //       child: Icon(Icons.mode_edit_outlined,
                            //           color: ColorManager.primary, size: 4.w),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                          "${cubit.profileModel!.data!.attributes!.firstName.toString() + cubit.profileModel!.data!.attributes!.lastName.toString()}",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 19.sp),
                        ),
                        Text(
                          "${cubit.profileModel!.data!.relationships!.user!.email.toString()}",
                          style: TextStyle(
                              fontSize: 16.sp, color: ColorManager.grey1),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        ProfileInfoCard(
                          icona: Icons.person_pin,
                          iconColor: ColorManager.darkGrey,
                          txt: "Edit Profile",
                          onPress: () => Functions.navigatorPush(
                              context, EditProfileScreen()),
                        ),
                        // ProfileInfoCard(
                        //   icona: Icons.logout,
                        //   iconColor: ColorManager.grey,
                        //   txt: "Personal Info",
                        //   onPress: () => Functions.navigatorPush(
                        //       context, DoctorDetailsScreen()),
                        // ),
                        ProfileInfoCard(
                            icona: Icons.logout_sharp,
                            iconColor: ColorManager.grey,
                            txt: "LogOut",
                            onPress: () {
                              cubit.logOut();
                              CacheHelper.sharedPreferences!
                                  .remove("barrierToken")
                                  .then((value) {
                                cubit.profileModel == null;
                                Functions.navigatorPushAndRemove(
                                    context, LoginScreen());
                              });
                            }),
                      ],
                    ),
                  ),
                  fallback: (context) => Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      listener: (context, state) {},
    );
  }
}
