import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediclica/componnets/doctor_card_widget.dart';
import 'package:mediclica/resources/color_manager.dart';
import 'package:mediclica/screens/Doctor/search_doctors_screen.dart';
import 'package:mediclica/screens/Layout/Bloc/cubit.dart';
import 'package:mediclica/screens/Layout/Bloc/states.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../componnets/functions.dart';
import 'doctor_details.dart';

class DoctorsScreen extends StatefulWidget {
  DoctorsScreen({Key? key}) : super(key: key);

  @override
  State<DoctorsScreen> createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen>
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
              "Doctors",
              style: TextStyle(
                  color: ColorManager.black, fontWeight: FontWeight.w500),
            ),
          ),
          body: OverlayLoaderWithAppIcon(
            borderRadius: 90.w,
            appIconSize: 20.w,
            appIcon: ClipRRect(
                borderRadius: BorderRadius.circular(20.w),
                child: Image.asset("assets/Mediclica.jpg")),
            overlayBackgroundColor: ColorManager.lightGrey,
            circularProgressColor: ColorManager.grey,
            isLoading: state is LayoutGetDoctorsLoadingState,
            child: Padding(
              padding: EdgeInsets.only(right: 5.w, bottom: 5.w, left: 5.w),
              child: Column(
                children: [
                  InkWell(
                    onTap: () =>
                        Functions.navigatorPush(context, SearchDoctorsScreen()),
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
                        SizedBox(
                          width: 1.w,
                        ),
                        Image.asset(
                          "assets/sortFilter.png",
                          height: 3.5.h,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  ConditionalBuilder(
                    condition: state is! LayoutGetDoctorsLoadingState,
                    builder: (context) => Expanded(
                      child: ListView.builder(
                        controller: cubit.scrollController,
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
                                  (index / cubit.getDoctorModel!.data!.length) *
                                      0.9,
                                  1.0,
                                  curve: Curves.easeOut,
                                ),
                              ),
                            ),
                            child: InkWell(
                              overlayColor:
                                  MaterialStateProperty.all(ColorManager.grey2),
                              borderRadius: BorderRadius.circular(18),
                              onTap: () async {
                                cubit.getDoctorDetaiels(
                                    doctorID:
                                        cubit.getDoctorModel!.data![index].id!);
                                Functions.navigatorPush(
                                    context, DoctorDetailsScreen());
                              },
                              child: DoctorCardWidget(
                                  getDoctorModel:
                                      cubit.getDoctorModel!.data![index]),
                            ),
                          );
                        },
                        itemCount: cubit.getDoctorModel!.data!.length,
                      ),
                    ),
                    fallback: (context) => Center(
                      child: Container(),
                    ),
                  )
                ],
              ),
            ),
          )),
      listener: (context, state) {},
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    // LayoutCubit.get(context).scrollController!.dispose();
    super.dispose();
  }
}
