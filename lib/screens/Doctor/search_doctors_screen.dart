import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:mediclica/screens/Layout/Bloc/cubit.dart';
import 'package:mediclica/screens/Layout/Bloc/states.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../componnets/available_service_card.dart';
import '../../componnets/button_width.dart';
import '../../componnets/doctor_card_widget.dart';
import '../../componnets/functions.dart';
import '../../componnets/timer.dart';
import '../../resources/color_manager.dart';
import 'doctor_details.dart';

class SearchDoctorsScreen extends StatelessWidget {
  ScrollController scrollControllerSpeciality = ScrollController();

  ScrollController scrollControllerRating = ScrollController();

  bool specialityActive = false;

  bool ratingActive = false;

  final debouncer = Debouncer(milliseconds: 700);

  @override
  Widget build(BuildContext context) {
    LayoutCubit cubit = LayoutCubit.get(context);
    return BlocConsumer<LayoutCubit, LayoutStates>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            "Search Doctors",
            style: TextStyle(
                color: ColorManager.black, fontWeight: FontWeight.w500),
          ),
        ),
        body: PopScope(
          onPopInvoked: (didPop) {
            cubit.searchDoctorModel!.data!.clear();
            cubit.anyDoctorsSearchResult = false;
          },
          child: OverlayLoaderWithAppIcon(
            isLoading: state is SearchDoctorLoadingState,
            borderRadius: 90.w,
            appIconSize: 20.w,
            appIcon: ClipRRect(
                borderRadius: BorderRadius.circular(20.w),
                child: Image.asset("assets/Mediclica.jpg")),
            overlayBackgroundColor: ColorManager.lightGrey,
            circularProgressColor: ColorManager.grey,
            child: Padding(
              padding: EdgeInsets.all(5.w),
              child: SingleChildScrollView(
                child: Container(
                  height: 100.h,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              height: 5.h,
                              decoration: BoxDecoration(
                                color: ColorManager.grey2,
                                borderRadius: BorderRadius.circular(3.w),
                              ),
                              child: TextFormField(
                                onChanged: (value) async {
                                  await debouncer.run(() {
                                    if (value.length < 2 || value.isEmpty) {
                                      cubit.searchDoctorModel!.data!.clear();

                                      cubit.anyDoctorsSearchResult = false;
                                    } else if (value.length > 2)
                                      cubit.searchDoctors(doctorName: value);
                                  });
                                },
                                scrollPhysics: BouncingScrollPhysics(),
                                scribbleEnabled: true,
                                enableInteractiveSelection: false,
                                decoration: InputDecoration(
                                  fillColor: ColorManager.primary,
                                  focusColor: ColorManager.primary,
                                  hoverColor: ColorManager.primary,
                                  hintFadeDuration: Duration(milliseconds: 300),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      3.w,
                                    ),
                                    borderSide: BorderSide.none,
                                  ),
                                  prefixIcon: Image.asset(
                                    "assets/search.png",
                                    filterQuality: FilterQuality.high,
                                  ),
                                  hintText: "Search",
                                  contentPadding: EdgeInsets.only(top: 2.h),
                                  hintStyle: TextStyle(
                                    color: ColorManager.grey1,
                                  ),
                                ),
                                cursorColor: ColorManager.grey,
                                cursorRadius: Radius.circular(3.w),
                                cursorOpacityAnimates: true,
                                textInputAction: TextInputAction.search,
                                dragStartBehavior: DragStartBehavior.start,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return BlocBuilder<LayoutCubit, LayoutStates>(
                                    builder: (context, state) => Container(
                                      padding: EdgeInsets.all(5.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Center(
                                            child: Text(
                                              'Sort By',
                                              style: TextStyle(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                          Divider(),
                                          SizedBox(height: 4.h),
                                          Text(
                                            "Speciality",
                                            style: TextStyle(
                                                fontSize: 17.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(height: 4.h),
                                          Container(
                                            child: ListView.separated(
                                              controller:
                                                  scrollControllerSpeciality,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) =>
                                                  InkWell(
                                                onTap: () {
                                                  cubit.SearchserviceStatus(
                                                      index);
                                                },
                                                child: AvailableServiceCard(
                                                  categoriesData: cubit
                                                      .categoriesModel!
                                                      .data![index],
                                                  index: index,
                                                ),
                                              ),
                                              separatorBuilder:
                                                  (context, index) => SizedBox(
                                                width: 1.w,
                                              ),
                                              itemCount: cubit.categoriesModel!
                                                  .data!.length,
                                            ),
                                            height: 5.h,
                                          ),
                                          SizedBox(height: 6.h),
                                          Row(
                                            children: [
                                              widthButton(
                                                textButton: "Done",
                                                onPress: () {
                                                  cubit.searchDoctors(
                                                      category: cubit
                                                          .categoriesModel!
                                                          .data![cubit
                                                              .selectIndex!]
                                                          .id!);
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            icon: Image.asset(
                              "assets/sortFilter.png",
                              height: 3.h,
                              width: 6.w,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      ConditionalBuilder(
                          condition: cubit.anyDoctorsSearchResult,
                          builder: (context) {
                            return cubit.searchDoctorModel!.data!.isNotEmpty
                                ? Expanded(
                                    child: ListView.builder(
                                      padding: EdgeInsets.all(2.w),
                                      physics: BouncingScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          overlayColor:
                                              MaterialStateProperty.all(
                                                  ColorManager.grey2),
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          onTap: () {
                                            cubit.getDoctorDetaiels(
                                                doctorID: cubit
                                                    .searchDoctorModel!
                                                    .data![index]
                                                    .id!);
                                            Functions.navigatorPush(
                                                context, DoctorDetailsScreen());
                                          },
                                          child: DoctorCardWidget(
                                              searchDoctorData: cubit
                                                  .searchDoctorModel!
                                                  .data![index]),
                                        );
                                      },
                                      itemCount: cubit.anyDoctorsSearchResult
                                          ? cubit
                                              .searchDoctorModel!.data!.length
                                          : 0,
                                    ),
                                  )
                                : Lottie.asset("assets/noitem3.json");
                          },
                          fallback: (context) => Container())
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      listener: (context, state) {},
    );
  }
}
