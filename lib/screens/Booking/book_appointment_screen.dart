import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediclica/componnets/available_service_card.dart';
import 'package:mediclica/componnets/show_toast.dart';
import 'package:mediclica/models/DoctorsScreensModels/doctor_dates_model.dart';
import 'package:mediclica/resources/color_manager.dart';
import 'package:mediclica/screens/Layout/Bloc/cubit.dart';
import 'package:mediclica/screens/Layout/Bloc/states.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../componnets/available_time_card.dart';
import '../../componnets/availiable_date_card.dart';
import '../../componnets/button_width.dart';
import '../../componnets/functions.dart';
import 'booking_details_screen.dart';

class BookAppointmentScreen extends StatelessWidget {
  BookAppointmentScreen({this.doctorDatesModel});
  ScrollController scrollControllerDate = ScrollController();

  ScrollController scrollControllerService = ScrollController();
  bool serviceActive = false;
  bool dateActive = false;

  bool timeActive = false;

  DoctorDatesModel? doctorDatesModel;

  @override
  Widget build(BuildContext context) {
    LayoutCubit cubit = LayoutCubit.get(context);
    return BlocConsumer<LayoutCubit, LayoutStates>(
      builder: (context, state) => PopScope(
        onPopInvoked: (didPop) {
          // cubit.doctorWorkHoursModel = null;
          // cubit.doctorDatesModel = null;
          // cubit.doctorServicesModel = null;
          cubit.serviceActive = false;
          cubit.dateActive = false;
          cubit.timeActive = false;
          cubit.selectTimeIndex = null;
          cubit.selectDateIndex = null;
          cubit.selectIndex = null;
          cubit.getServicesData = false;
          cubit.getDoctorDatesData = false;
          cubit.getworkhoursData = false;
          cubit.changedTime = false;
        },
        child: AbsorbPointer(
          absorbing: state is MakeAppointmentLoadingState,
          child: Container(
            decoration: BoxDecoration(
              color: state is MakeAppointmentLoadingState
                  ? Colors.black12
                  : Colors.transparent,
            ),
            child: Stack(
              children: [
                Scaffold(
                  appBar: AppBar(
                    forceMaterialTransparency: true,
                    centerTitle: true,
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    // leading: Padding(
                    //   padding: EdgeInsets.all(1.w),
                    //   child: Container(
                    //     height: 6.h,
                    //     width: 12.w,
                    //     child: IconButton(
                    //         onPressed: () {
                    //           Navigator.pop(context);
                    //         },
                    //         icon: Icon(
                    //           Icons.arrow_back_ios_new,
                    //           size: 5.w,
                    //           color: Colors.black,
                    //         )),
                    //     decoration: BoxDecoration(
                    //       color: Colors.white70,
                    //       border: Border.all(color: ColorManager.grey2),
                    //       borderRadius: BorderRadius.circular(3.w),
                    //     ),
                    //   ),
                    // ),
                    title: Text(
                      "Book Appointment",
                      style: TextStyle(
                          color: ColorManager.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  body: ConditionalBuilder(
                    condition:
                        cubit.getDoctorDatesData && cubit.getServicesData,
                    builder: (context) {
                      return Column(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(5.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Select Service",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 19.sp),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        cubit.doctorServicesModel!.data!
                                                    .length >
                                                3
                                            ? IconButton(
                                                onPressed: () {
                                                  scrollControllerService
                                                      .animateTo(
                                                          scrollControllerService
                                                                  .position
                                                                  .pixels -
                                                              75,
                                                          duration: Duration(
                                                              milliseconds:
                                                                  200),
                                                          curve: Curves
                                                              .easeOutQuint);
                                                },
                                                icon: Icon(
                                                    Icons.arrow_back_ios_new),
                                                visualDensity: VisualDensity(
                                                    horizontal: -4),
                                                padding: EdgeInsets.zero,
                                              )
                                            : Container(),
                                        Expanded(
                                          child: Container(
                                            height: 6.h,
                                            child: ListView.separated(
                                                controller:
                                                    scrollControllerService,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder: (context, index) =>
                                                    InkWell(
                                                      onTap: () {
                                                        cubit.serviceStatus(
                                                            index);
                                                      },
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              2.h),
                                                      overlayColor:
                                                          MaterialStatePropertyAll(
                                                              ColorManager
                                                                  .grey2),
                                                      child:
                                                          AvailableServiceCard(
                                                        doctorServicesData: cubit
                                                            .doctorServicesModel!
                                                            .data![index],
                                                        index: index,
                                                      ),
                                                    ),
                                                separatorBuilder:
                                                    (context, index) =>
                                                        SizedBox(
                                                          width: 1.w,
                                                        ),
                                                itemCount: cubit
                                                    .doctorServicesModel!
                                                    .data!
                                                    .length),
                                          ),
                                        ),
                                        cubit.doctorServicesModel!.data!
                                                    .length >
                                                3
                                            ? IconButton(
                                                onPressed: () {
                                                  scrollControllerService
                                                      .animateTo(
                                                          scrollControllerService
                                                                  .position
                                                                  .pixels +
                                                              75,
                                                          duration: Duration(
                                                              milliseconds:
                                                                  200),
                                                          curve: Curves
                                                              .easeOutQuint);
                                                },
                                                icon: Icon(
                                                    Icons.arrow_forward_ios),
                                                padding: EdgeInsets.zero,
                                                visualDensity: VisualDensity(
                                                    horizontal: -4),
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Text(
                                    "Select Date",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 19.sp),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            scrollControllerDate.animateTo(
                                                scrollControllerDate
                                                        .position.pixels -
                                                    75,
                                                duration:
                                                    Duration(milliseconds: 200),
                                                curve: Curves.easeOutQuint);
                                          },
                                          icon: Icon(Icons.arrow_back_ios_new),
                                          visualDensity:
                                              VisualDensity(horizontal: -4),
                                          padding: EdgeInsets.zero,
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 10.h,
                                            child: ListView.separated(
                                                controller:
                                                    scrollControllerDate,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder:
                                                    (context, index) => InkWell(
                                                          onTap: () {
                                                            cubit.serviceActive
                                                                ? cubit
                                                                        .doctorDatesModel!
                                                                        .data![
                                                                            index]
                                                                        .isVacation!
                                                                    ? null
                                                                    : {
                                                                        LayoutCubit.get(context)
                                                                            .dateStatus(index),
                                                                        !cubit
                                                                                .getdoctorCategories
                                                                            ? cubit
                                                                                .getDoctorWorkHours(
                                                                                doctorID: cubit.doctorDetaielsModel!.data!.id!,
                                                                                serviceId: cubit.serviceid,
                                                                                date: cubit.dateSelected!,
                                                                              )
                                                                            : cubit.getDoctorWorkHours(
                                                                                doctorID: cubit.doctorInCenterId,
                                                                                serviceId: cubit.serviceid,
                                                                                date: cubit.dateSelected!,
                                                                                centerID: cubit.centerID),
                                                                        cubit.selectTimeIndex =
                                                                            null,
                                                                      }
                                                                : showToast(
                                                                    message:
                                                                        "Select Service "
                                                                        "First");
                                                          },
                                                          child: AviliableDateCard(
                                                              doctorDatesData: cubit
                                                                  .doctorDatesModel!
                                                                  .data![index],
                                                              id: index),
                                                        ),
                                                separatorBuilder:
                                                    (context, index) =>
                                                        SizedBox(
                                                          width: 1.w,
                                                        ),
                                                itemCount: cubit
                                                    .doctorDatesModel!
                                                    .data!
                                                    .length),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            scrollControllerDate.animateTo(
                                                scrollControllerDate
                                                        .position.pixels +
                                                    75,
                                                duration:
                                                    Duration(milliseconds: 200),
                                                curve: Curves.easeOutQuint);
                                          },
                                          icon: Icon(Icons.arrow_forward_ios),
                                          padding: EdgeInsets.zero,
                                          visualDensity:
                                              VisualDensity(horizontal: -4),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Text(
                                    "Avilibale Time",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 19.sp),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  ConditionalBuilder(
                                    condition: cubit.getworkhoursData,
                                    builder: (context) {
                                      return Expanded(
                                        child: GridView.builder(
                                          scrollDirection: Axis.vertical,
                                          physics: BouncingScrollPhysics(),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 2.w, vertical: 1.h),
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 2.h,
                                            crossAxisSpacing: 2.w,
                                            childAspectRatio: 4.w / 5,
                                          ),
                                          itemBuilder: (context, index) =>
                                              InkWell(
                                            onTap: () {
                                              cubit.doctorWorkHoursModel!
                                                      .data![index].available!
                                                  ? LayoutCubit.get(context)
                                                      .timeStatus(index)
                                                  : null;
                                            },
                                            child: AviliableTimeCard(
                                              index: index,
                                            ),
                                          ),
                                          itemCount: cubit.doctorWorkHoursModel!
                                              .data!.length,
                                        ),
                                      );
                                    },
                                    fallback: (context) => cubit.dateActive ==
                                            false
                                        ? Container()
                                        : Center(
                                            child: CircularProgressIndicator()),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      );
                    },
                    fallback: (context) =>
                        Center(child: CircularProgressIndicator()),
                  ),
                  bottomNavigationBar: Padding(
                    padding: EdgeInsets.all(2.w),
                    child: Row(
                      children: [
                        widthButton(
                          onPress: () {
                            !cubit.getdoctorCategories
                                ? cubit.bookAppointment(
                                    doctorID:
                                        cubit.doctorDetaielsModel!.data!.id!,
                                    serviceId: cubit.serviceid,
                                    date: cubit.dateSelected!,
                                    hour: cubit.workHourSelected!)
                                : cubit.bookAppointment(
                                    doctorID: cubit.doctorInCenterId,
                                    serviceId: cubit.serviceid,
                                    date: cubit.dateSelected!,
                                    hour: cubit.workHourSelected!,
                                    centerID: cubit.centerID);
                          },
                          textButton: "Continue",
                        ),
                      ],
                    ),
                  ),
                ),
                if (state is MakeAppointmentLoadingState)
                  Container(
                      alignment: AlignmentDirectional.center,
                      decoration: BoxDecoration(
                        color: Colors.white60,
                      ),
                      child: CircularProgressIndicator()),
              ],
            ),
          ),
        ),
      ),
      listener: (context, state) {
        if (state is MakeAppointmentSucsessState) {
          showToast(message: cubit.bookAppointmentModel!.message!);
          Functions.navigatorPush(context, BookingDetailsScreen());
        } else if (state is MakeAppointmentErrorState) {
          showToast(message: "YouHaveAppoinmentIn Same Time ");
        }
      },
    );
  }
}
