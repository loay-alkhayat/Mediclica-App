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
import 'package:responsive_sizer/responsive_sizer.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LayoutCubit cubit = LayoutCubit.get(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManager.primary,
        body: Stack(
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
            BlocBuilder<LayoutCubit, LayoutStates>(
              builder: (context, state) {
                return ConditionalBuilder(
                  condition: cubit.getProfileData,
                  builder: (context) => Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16.w),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: CircleAvatar(
                            backgroundColor: ColorManager.white,
                            radius: 14.w,
                            child: Image.asset("assets/profile.png"),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                          cubit.profileModel!.data!.attributes!.firstName
                                  .toString() +
                              cubit.profileModel!.data!.attributes!.lastName
                                  .toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 19.sp),
                        ),
                        Text(
                          cubit.profileModel!.data!.relationships!.user!.email
                              .toString(),
                          style: TextStyle(
                              fontSize: 16.sp, color: ColorManager.grey1),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
