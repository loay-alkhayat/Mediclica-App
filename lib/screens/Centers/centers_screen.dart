import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:mediclica/resources/color_manager.dart';
import 'package:mediclica/screens/Layout/Bloc/cubit.dart';
import 'package:mediclica/screens/Layout/Bloc/states.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../componnets/center_card_widget.dart';
import '../../componnets/functions.dart';
import 'center_details_screen.dart';

class CentersScreen extends StatefulWidget {
  CentersScreen({Key? key}) : super(key: key);

  @override
  State<CentersScreen> createState() => _CentersScreenState();
}

class _CentersScreenState extends State<CentersScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
              "Centers",
              style: TextStyle(
                  color: ColorManager.black, fontWeight: FontWeight.w500),
            ),
          ),
          body: OverlayLoaderWithAppIcon(
            isLoading: state is GetCentersLoadingState,
            child: Padding(
              padding: EdgeInsets.only(bottom: 5.w, right: 5.w, left: 5.w),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {}
                    // Functions.navigatorPush(context, SearchCentersScreen()),
                    ,
                    overlayColor: MaterialStatePropertyAll(Colors.transparent),
                    child: Row(
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
                              enabled: false,
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
                        // SizedBox(
                        //   width: 1.w,
                        // ),
                        // Image.asset(
                        //   "assets/sortFilter.png",
                        //   height: 3.5.h,
                        // )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  ConditionalBuilder(
                    condition: cubit.getCentersData,
                    builder: (context) => Expanded(
                      child: cubit.centersModel!.data!.isNotEmpty
                          ? ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return SlideTransition(
                                  position: Tween<Offset>(
                                    begin: Offset(1.0, 0.0),
                                    end: Offset.zero,
                                  ).animate(
                                    CurvedAnimation(
                                      parent: _controller,
                                      curve: Interval(
                                        (index /
                                                cubit.centersModel!.data!
                                                    .length) *
                                            0.9, // Adjust the interval as needed
                                        1.0,
                                        curve: Curves.easeOut,
                                      ),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 5.h),
                                    child: InkWell(
                                      overlayColor: MaterialStatePropertyAll(
                                          ColorManager.grey2),
                                      borderRadius: BorderRadius.circular(18),
                                      onTap: () async {
                                        cubit.centerID = cubit
                                            .centersModel!.data![index].id!;

                                        await cubit.getCenterById(
                                            centerID: cubit.centersModel!
                                                .data![index].id!);
                                        print(cubit.centerID);
                                        Functions.navigatorPush(
                                            context, CenterDetailsScreen());
                                      },
                                      child: CenterCardWidget(
                                          centersData:
                                              cubit.centersModel!.data![index]),
                                    ),
                                  ),
                                );
                              },
                              itemCount: cubit.centersModel!.data!.length,
                            )
                          : Lottie.asset('assets/noitem3.json',
                              fit: BoxFit.fill, width: 100.w, height: 2.h),
                    ),
                    fallback: (context) => Center(
                      child: Container(),
                    ),
                  )
                ],
              ),
            ),
            borderRadius: 90.w,
            appIconSize: 20.w,
            appIcon: ClipRRect(
                borderRadius: BorderRadius.circular(20.w),
                child: Image.asset("assets/Mediclica.jpg")),
            overlayBackgroundColor: ColorManager.lightGrey,
            circularProgressColor: ColorManager.grey,
          )),
      listener: (context, state) {},
    );
  }
}

// Row(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Container(
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(10.h),
// ),
// height: 11.h,
// width: 21.w,
// child: ClipRRect(
// child: Image.asset("assets/doctor_image.png"),
// borderRadius:
// BorderRadius.all(Radius.circular(2.h))),
// ),
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: Column(
// mainAxisAlignment: MainAxisAlignment.start,
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Container(
// child: Text(
// "Dr.Loay Alkhayat",
// overflow: TextOverflow.ellipsis,
// style: TextStyle(
// fontWeight: FontWeight.w600,
// fontSize: 17.sp),
// ),
// width: 50.w,
// ),
// SizedBox(
// height: 1.h,
// ),
// Text(
// "General",
// style: TextStyle(color: ColorManager.grey),
// ),
// SizedBox(
// height: 1.h,
// ),
// Row(
// children: [
// Icon(
// Icons.star,
// color: ColorManager.amber,
// size: 5.w,
// ),
// SizedBox(
// width: 1.w,
// ),
// Text("4.5",
// style: TextStyle(
// color: ColorManager.grey)),
// ],
// )
// ],
// ),
// ),
// ],
// ),
