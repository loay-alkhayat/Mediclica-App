import 'package:flutter/material.dart';
import 'package:mediclica/resources/color_manager.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../models/MainScreensModels/my_appointment_model.dart';

class MyAppoinmentsCard extends StatelessWidget {
  MyAppoinmentsCard({
    super.key,
    this.myAppointmentData,
  });
  MyAppointmentData? myAppointmentData;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 10.h,
          width: 20.w,
          child: CircleAvatar(
              backgroundColor: ColorManager.lightGrey,
              radius: 3.w,
              backgroundImage: NetworkImage("https://medical.alhasanshnnar"
                  ".com/${myAppointmentData!.relationships!.image!}")),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50.w,
                child: Text(
                  myAppointmentData!.relationships!.doctor!.displayName!
                      .toString(),
                  overflow: TextOverflow.ellipsis,
                  style:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 17.sp),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                myAppointmentData!.attributes!.startTime! +
                    "  |  " +
                    myAppointmentData!.attributes!.date!,
                style: TextStyle(color: ColorManager.grey, fontSize: 16.sp),
              ),
              SizedBox(
                height: 1.h,
              ),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: ColorManager.amber,
                    size: 5.w,
                  ),
                  SizedBox(
                    width: 1.w,
                  ),
                  Text("4.5", style: TextStyle(color: ColorManager.grey)),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
