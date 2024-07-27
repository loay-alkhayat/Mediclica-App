import 'package:flutter/material.dart';
import 'package:mediclica/models/MainScreensModels/get_doctors_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../models/CenterScreensModels/center_doctors_by_category_model.dart';
import '../models/DoctorsScreensModels/doctor_detaiels_model.dart';
import '../models/DoctorsScreensModels/search_doctor_model.dart';
import '../resources/color_manager.dart';

class DoctorCardWidget extends StatelessWidget {
  bool appointmentScreen;
  GetDoctorsData? getDoctorModel;
  DoctorDetaielsData? doctorDetaielsData;
  SearchDoctorData? searchDoctorData;
  CenterDoctorsByGategoryData? centerDoctorsByGategoryData;

  DoctorCardWidget(
      {this.appointmentScreen = false,
      this.getDoctorModel,
      this.doctorDetaielsData,
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
                width: 50.w,
                child: Text(
                  searchDoctorData != null
                      ? searchDoctorData!.attributes!.displayName!
                      : getDoctorModel != null
                          ? getDoctorModel!.attributes!.displayName.toString()
                          : doctorDetaielsData!.attributes!.displayName
                              .toString(),
                  overflow: TextOverflow.ellipsis,
                  style:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 17.sp),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              !appointmentScreen
                  ? Container(
                      width: 50.w,
                      child: Text(
                        searchDoctorData != null
                            ? searchDoctorData!.relationships!.category!.name!
                            : getDoctorModel != null
                                ? getDoctorModel!.relationships!.category!.name
                                    .toString()
                                : doctorDetaielsData!
                                    .relationships!.category!.name
                                    .toString(),
                        style: TextStyle(color: ColorManager.grey),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    )
                  : Container(),
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
