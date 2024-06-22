import 'package:flutter/material.dart';
import 'package:mediclica/resources/color_manager.dart';
import 'package:mediclica/screens/Layout/Bloc/cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../componnets/button_width.dart';
import '../../componnets/doctor_card_widget.dart';

class BookingDetailsScreen extends StatelessWidget {
  const BookingDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Padding(
            padding: EdgeInsets.all(1.w),
          ),
          title: Text(
            "Appointment Details",
            style: TextStyle(
                color: ColorManager.black, fontWeight: FontWeight.w600),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(6.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(6.w),
                      child: CircleAvatar(
                        radius: 10.w,
                        backgroundColor: Colors.green.shade300,
                        foregroundColor: Colors.green.shade300,
                        child: Icon(
                          Icons.done,
                          color: ColorManager.white,
                          size: 12.w,
                        ),
                      ),
                    ),
                    Text(
                      "Booking Sended",
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              // Container(
              //   height: 14.h,
              //   child: Row(
              //     children: [
              //       TimelineTile(
              //         afterLineStyle: LineStyle(color: Colors.green),
              //         isFirst: true,
              //         axis: TimelineAxis.horizontal,
              //         endChild: Container(
              //           child: Padding(
              //             padding: EdgeInsets.symmetric(horizontal: 12.w),
              //             child: Text(
              //               'Date & Time',
              //               style:
              //                   TextStyle(fontSize: 16.sp, color: Colors.green),
              //             ),
              //           ),
              //         ),
              //         indicatorStyle: IndicatorStyle(
              //           indicator: Container(
              //             width: 10.w,
              //             height: 6.h,
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(10.w),
              //               color: Colors.green,
              //             ),
              //             child: Center(
              //                 child: Text(
              //               "1",
              //               style: TextStyle(
              //                   color: Colors.white, fontWeight: FontWeight.bold),
              //             )),
              //           ),
              //           width: 10.w,
              //           height: 5.h,
              //           padding: EdgeInsets.all(8),
              //         ),
              //       ),
              //       TimelineTile(
              //         isFirst: false,
              //         isLast: true,
              //         axis: TimelineAxis.horizontal,
              //         alignment: TimelineAlign.start,
              //         endChild: Container(
              //           constraints: const BoxConstraints(
              //             minHeight: 80,
              //           ),
              //           child: Padding(
              //             padding: EdgeInsets.symmetric(horizontal: 12.w),
              //             child: Text(
              //               'Summary',
              //               style: TextStyle(
              //                   fontSize: 16.sp, color: ColorManager.black),
              //             ),
              //           ),
              //         ),
              //         beforeLineStyle: LineStyle(color: ColorManager.grey1),
              //         indicatorStyle: IndicatorStyle(
              //           indicator: Container(
              //             width: 10.w,
              //             height: 6.h,
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(10.w),
              //               color: ColorManager.primary,
              //             ),
              //             child: Center(
              //                 child: Text(
              //               "2",
              //               style: TextStyle(
              //                   color: Colors.white, fontWeight: FontWeight.bold),
              //             )),
              //           ),
              //           width: 10.w,
              //           height: 5.h,
              //           padding: EdgeInsets.all(8),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(
                height: 4.h,
              ),
              Text(
                "Booking Information",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 3.h,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 6.h,
                    width: 12.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.w),
                        color: ColorManager.lightprimary),
                    child: Icon(
                      Icons.calendar_month_outlined,
                      color: ColorManager.darkprimary,
                    ),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Date & Time",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(
                        height: 0.2.h,
                      ),
                      Text(
                        LayoutCubit.get(context).dateSelected.toString(),
                        style: TextStyle(
                          color: ColorManager.grey1,
                          fontSize: 15.sp,
                        ),
                      ),
                      Text(
                        LayoutCubit.get(context).workHourSelected.toString(),
                        style: TextStyle(
                          color: ColorManager.grey1,
                          fontSize: 15.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              Divider(
                color: ColorManager.lightGrey,
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                "Doctor Information",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 3.h,
              ),
              DoctorCardWidget(
                doctorDetaielsData:
                    LayoutCubit.get(context).doctorDetaielsModel!.data,
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(2.w),
          child: Row(
            children: [
              widthButton(
                textButton: "Done",
                onPress: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
