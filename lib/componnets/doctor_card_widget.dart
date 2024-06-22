import 'package:flutter/material.dart';
import 'package:mediclica/models/MainScreensModels/get_doctors_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../models/CenterScreensModels/center_doctors_by_category_model.dart';
import '../models/DoctorsScreensModels/doctor_detaiels_model.dart';
import '../models/DoctorsScreensModels/search_doctor_model.dart';
import '../models/MainScreensModels/my_appointment_model.dart';
import '../resources/color_manager.dart';

class DoctorCardWidget extends StatelessWidget {
  bool appointmentScreen;
  GetDoctorsData? getDoctorModel;
  DoctorDetaielsData? doctorDetaielsData;
  MyAppointmentData? myAppointmentData;
  SearchDoctorData? searchDoctorData;
  CenterDoctorsByGategoryData? centerDoctorsByGategoryData;

  DoctorCardWidget(
      {this.appointmentScreen = false,
      this.getDoctorModel,
      this.doctorDetaielsData,
      this.myAppointmentData,
      this.searchDoctorData});

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
            backgroundImage: getDoctorModel != null
                ? NetworkImage(
                    "https://medical.alhasanshnnar.com/${getDoctorModel!.attributes!.image!}")
                : doctorDetaielsData != null
                    ? NetworkImage("https://medical.alhasanshnnar"
                        ".com/${doctorDetaielsData!.attributes!.image!}")
                    : searchDoctorData != null
                        ? NetworkImage("https://medical.alhasanshnnar"
                            ".com/${searchDoctorData!.attributes!.image!}")
                        : myAppointmentData != null
                            ? NetworkImage("https://medical.alhasanshnnar"
                                ".com/${myAppointmentData!.relationships!.image!}")
                            : NetworkImage('assets/doctor_image.png'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  "${searchDoctorData != null ? searchDoctorData!.attributes!.displayName! : myAppointmentData != null ? myAppointmentData!.relationships!.doctor!.displayName!.toString() : getDoctorModel != null ? getDoctorModel!.attributes!.displayName.toString() : doctorDetaielsData!.attributes!.displayName.toString()}",
                  overflow: TextOverflow.ellipsis,
                  style:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 17.sp),
                ),
                width: 50.w,
              ),
              SizedBox(
                height: 1.h,
              ),
              !appointmentScreen
                  ? Text(
                      searchDoctorData != null
                          ? searchDoctorData!.relationships!.category!.name!
                          : myAppointmentData != null
                              ? myAppointmentData!.attributes!.category!
                              : getDoctorModel != null
                                  ? getDoctorModel!
                                      .relationships!.category!.name
                                      .toString()
                                  : doctorDetaielsData!
                                      .relationships!.category!.name
                                      .toString(),
                      style: TextStyle(color: ColorManager.grey),
                    )
                  : Container(),
              SizedBox(
                height: 1.h,
              ),
              !appointmentScreen
                  ? Row(
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
                  : Text(
                      myAppointmentData!.attributes!.startTime! +
                          "  |  " +
                          myAppointmentData!.attributes!.date!,
                      style:
                          TextStyle(color: ColorManager.grey, fontSize: 16.sp),
                    ),
            ],
          ),
        ),
      ],
    );
  }
}
