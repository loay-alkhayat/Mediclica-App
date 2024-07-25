import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../componnets/doctor_card_widget.dart';
import '../../componnets/functions.dart';
import '../../resources/color_manager.dart';
import '../Doctor/doctor_details.dart';

class SearchCentersScreen extends StatelessWidget {
  SearchCentersScreen({Key? key}) : super(key: key);
  ScrollController scrollControllerSpeciality = ScrollController();

  ScrollController scrollControllerRating = ScrollController();

  bool specialityActive = false;

  bool ratingActive = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Search Centers",
          style:
              TextStyle(color: ColorManager.black, fontWeight: FontWeight.w500),
        ),
      ),
      body: OverlayLoaderWithAppIcon(
        isLoading: false,
        borderRadius: 90.w,
        appIconSize: 20.w,
        appIcon: Image.asset("assets/profile.png"),
        overlayBackgroundColor: ColorManager.lightGrey,
        circularProgressColor: ColorManager.grey,
        child: Padding(
          padding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 5.w),
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
                  // IconButton(
                  //   onPressed: () {
                  //     showModalBottomSheet(
                  //       context: context,
                  //       builder: (BuildContext context) {
                  //         return Container(
                  //           padding: EdgeInsets.all(5.w),
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             mainAxisSize: MainAxisSize.max,
                  //             children: [
                  //               Center(
                  //                 child: Text(
                  //                   'Sort By',
                  //                   style: TextStyle(
                  //                       fontSize: 18.sp,
                  //                       fontWeight: FontWeight.w700),
                  //                 ),
                  //               ),
                  //               Divider(),
                  //               SizedBox(height: 4.h),
                  //               Text(
                  //                 "Speciality",
                  //                 style: TextStyle(
                  //                     fontSize: 17.sp,
                  //                     fontWeight: FontWeight.w500),
                  //               ),
                  //               SizedBox(height: 4.h),
                  //               Container(
                  //                 child: ListView.separated(
                  //                   controller: scrollControllerSpeciality,
                  //                   scrollDirection: Axis.horizontal,
                  //                   itemBuilder: (context, index) =>
                  //                       AvailableServiceCard(
                  //                           serviceActive: specialityActive),
                  //                   separatorBuilder: (context, index) =>
                  //                       SizedBox(
                  //                     width: 1.w,
                  //                   ),
                  //                   itemCount: 4,
                  //                 ),
                  //                 height: 5.h,
                  //               ),
                  //               SizedBox(height: 4.h),
                  //               Text(
                  //                 "Rating",
                  //                 style: TextStyle(
                  //                     fontSize: 17.sp,
                  //                     fontWeight: FontWeight.w500),
                  //               ),
                  //               SizedBox(height: 4.h),
                  //               Container(
                  //                 child: ListView.separated(
                  //                   controller: scrollControllerRating,
                  //                   scrollDirection: Axis.horizontal,
                  //                   itemBuilder: (context, index) =>
                  //                       AvailableServiceCard(
                  //                           serviceActive: ratingActive),
                  //                   separatorBuilder: (context, index) =>
                  //                       SizedBox(
                  //                     width: 1.w,
                  //                   ),
                  //                   itemCount: 4,
                  //                 ),
                  //                 height: 5.h,
                  //               ),
                  //               SizedBox(height: 6.h),
                  //               Row(
                  //                 children: [
                  //                   widthButton(
                  //                     textButton: "Done",
                  //                     onPress: () {
                  //                       Navigator.pop(context);
                  //                     },
                  //                   ),
                  //                 ],
                  //               ),
                  //             ],
                  //           ),
                  //         );
                  //       },
                  //     );
                  //   },
                  //   icon: Image.asset(
                  //     "assets/sortFilter.png",
                  //     height: 3.h,
                  //     width: 6.w,
                  //   ),
                  // ),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(2.w),
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      overlayColor:
                          MaterialStateProperty.all(ColorManager.grey2),
                      borderRadius: BorderRadius.circular(18),
                      onTap: () {
                        // Handle onTap
                        Functions.navigatorPush(context, DoctorDetailsScreen());
                      },
                      child: DoctorCardWidget(),
                    );
                  },
                  itemCount: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
