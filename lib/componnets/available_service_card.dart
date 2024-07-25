import 'package:flutter/material.dart';
import 'package:mediclica/models/DoctorsScreensModels/doctor_services_model.dart';
import 'package:mediclica/models/MainScreensModels/categories_model.dart';
import 'package:mediclica/screens/Layout/Bloc/cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../resources/color_manager.dart';

class AvailableServiceCard extends StatelessWidget {
  AvailableServiceCard(
      {this.doctorServicesData, required this.index, this.categoriesData});
  int? index;
  DoctorServicesData? doctorServicesData;
  Data? categoriesData;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25.w,
      height: 10.h,
      decoration: ShapeDecoration(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.w)),
          color: LayoutCubit.get(context).selectIndex == index
              ? ColorManager.primary
              : ColorManager.grey2),
      child: Center(
          child: Text(
        categoriesData == null
            ? doctorServicesData!.attributes!.name.toString()
            : categoriesData!.attributes!.name.toString(),
        style: TextStyle(
            color: LayoutCubit.get(context).selectIndex == index
                ? ColorManager.white
                : ColorManager.grey,
            fontSize: 17.sp,
            fontWeight: FontWeight.w500),
        textAlign: TextAlign.center,
      )),
    );
  }
}
