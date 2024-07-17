import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediclica/componnets/doctor_card_widget.dart';
import 'package:mediclica/resources/color_manager.dart';
import 'package:mediclica/screens/Layout/Bloc/cubit.dart';
import 'package:mediclica/screens/Layout/Bloc/states.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DoctorsScreen extends StatelessWidget {
  DoctorsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LayoutCubit cubit = LayoutCubit.get(context);
    return Scaffold(
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
        body: BlocBuilder<LayoutCubit, LayoutStates>(
          builder: (context, state) {
            return OverlayLoaderWithAppIcon(
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
                              scrollPhysics: const BouncingScrollPhysics(),
                              scribbleEnabled: true,
                              enableInteractiveSelection: false,
                              decoration: InputDecoration(
                                fillColor: ColorManager.primary,
                                focusColor: ColorManager.primary,
                                hoverColor: ColorManager.primary,
                                hintFadeDuration:
                                    const Duration(milliseconds: 300),
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
                    SizedBox(
                      height: 3.h,
                    ),
                    ConditionalBuilder(
                      condition: state is! LayoutGetDoctorsLoadingState,
                      builder: (context) => Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return DoctorCardWidget(
                                getDoctorModel:
                                    cubit.getDoctorModel!.data![index]);
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
            );
          },
        ));
  }
}
