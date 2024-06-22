import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediclica/componnets/doctor_card_widget.dart';
import 'package:mediclica/resources/color_manager.dart';
import 'package:mediclica/screens/AI/ai_screen.dart';
import 'package:mediclica/screens/Doctor/doctor_details.dart';
import 'package:mediclica/screens/Doctor/search_doctors_screen.dart';
import 'package:mediclica/screens/Layout/Bloc/cubit.dart';
import 'package:mediclica/screens/Layout/Bloc/states.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../componnets/functions.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    LayoutCubit cubit = LayoutCubit.get(context);
    return BlocConsumer<LayoutCubit, LayoutStates>(
      builder: (context, state) => SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.all(5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ConditionalBuilder(
                            condition: cubit.getProfileData,
                            builder: (context) => Text(
                                  "Hi, ${cubit.profileModel!.data!.attributes!.firstName}!",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18.sp),
                                ),
                            fallback: (context) => Container()),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          "How Are you Today?",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 14.sp),
                        ),
                      ],
                    ),
                    Spacer(),
                    SizedBox(
                      width: 1.w,
                    ),
                  ],
                ),
                SizedBox(
                  height: 4.h,
                ),
                Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 20.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Image.asset("assets/HomeScreenBackGroung.png"),
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 35.w,
                              child: Padding(
                                padding: EdgeInsets.only(left: 4.w),
                                child: Text(
                                  "Book and schedule with nearest doctor",
                                  style: TextStyle(
                                    fontSize: 17.sp,
                                    color: ColorManager.white,
                                  ),
                                  textAlign: TextAlign.start,
                                  maxLines: 3,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            // Padding(
                            //   padding: EdgeInsets.only(left: 4.w),
                            //   child: ElevatedButton(
                            //     onPressed: () async {
                            //       LayoutCubit.get(context).getCategories();
                            //       Functions.navigatorPush(
                            //           context, NearbyDoctorScreen());
                            //     },
                            //     child: Text(
                            //       "Find Nearby",
                            //       style: TextStyle(color: ColorManager.white),
                            //     ),
                            //   ),
                            // )
                          ],
                        ),
                        Spacer(),
                        Image.asset(
                          "assets/womenMainScreen.png",
                          height: 20.h,
                          width: 40.w,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 4.h,
                ),
                Row(
                  children: [
                    Text(
                      "Doctor Speciality",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 19.sp),
                    ),
                    Spacer(),
                  ],
                ),
                Container(
                  height: 14.h,
                  child: ConditionalBuilder(
                    condition: cubit.getCategoriesData,
                    builder: (context) => ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.w),
                            child: Container(
                              width: 16.w,
                              height: 7.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.w),
                                color: Color(0x11A9B2B9),
                              ),
                              child: IconButton(
                                onPressed: () async {
                                  cubit.searchDoctors(
                                      category: cubit
                                          .categoriesModel!.data![index].id);
                                  Functions.navigatorPush(
                                      context, SearchDoctorsScreen());
                                },
                                icon: cubit.categoriesModel!.data![index]
                                            .attributes!.image ==
                                        ""
                                    ? Image.asset("assets/categories.png")
                                    : ClipRRect(
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        borderRadius:
                                            BorderRadius.circular(20.w),
                                        child: Image.network(
                                            "https://medical.alhasanshnnar.com/${cubit.categoriesModel!.data![index].attributes!.image!}"),
                                      ),

                                // Image.network(
                                //   cubit.categoriesModel!.data![index]
                                //       .attributes!.image
                                //       .toString(),
                                //   fit: BoxFit.none,
                                // ),
                              ),
                            ),
                          ),
                          Container(
                            width: 20.w,
                            child: Text(
                              cubit.categoriesModel!.data![index].attributes!
                                  .name
                                  .toString(),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      separatorBuilder: (context, index) =>
                          SizedBox(width: 2.h),
                      itemCount: cubit.categoriesModel!.data!.length,
                    ),
                    fallback: (context) => ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Center(
                          child: CircularProgressIndicator(
                        color: ColorManager.lightprimary,
                      )),
                      separatorBuilder: (context, index) =>
                          SizedBox(width: 2.h),
                      itemCount: 10,
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  children: [
                    Text(
                      "Nearby Doctors",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 19.sp),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                ConditionalBuilder(
                  condition: cubit.getDoctorsData,
                  builder: (context) => Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              cubit.getDoctorDetaiels(
                                  doctorID:
                                      cubit.getDoctorModel!.data![index].id!);
                              Functions.navigatorPush(
                                  context, DoctorDetailsScreen());
                            },
                            child: DoctorCardWidget(
                              getDoctorModel:
                                  cubit.getDoctorModel!.data![index],
                            )),
                        separatorBuilder: (context, index) => SizedBox(
                              height: 2.h,
                            ),
                        itemCount: 4),
                  ),
                  fallback: (context) => Center(
                      child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: CircularProgressIndicator(),
                  )),
                )
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniEndFloat,
          floatingActionButton: CircleAvatar(
            backgroundColor: ColorManager.primary,
            radius: 5.w,
            child: TextButton(
              onPressed: () {
                Functions.navigatorPush(context, AIScreen());
              },
              child: Text(
                "AI",
                style: TextStyle(
                    color: ColorManager.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
      listener: (context, state) {},
    );
  }
}
