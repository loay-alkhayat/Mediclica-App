import 'package:flutter/material.dart';
import 'package:mediclica/models/DoctorsScreensModels/doctor_dates_model.dart';
import 'package:mediclica/screens/Layout/Bloc/cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../resources/color_manager.dart';

class AviliableDateCard extends StatelessWidget {
  AviliableDateCard({this.doctorDatesData, this.id});

  DoctorDatesData? doctorDatesData;
  int? id;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20.w,
      height: 12.h,
      decoration: ShapeDecoration(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.w)),
          color:
              LayoutCubit.get(context).doctorDatesModel!.data![id!].isVacation!
                  ? ColorManager.darkGrey
                  : LayoutCubit.get(context).selectDateIndex == id
                      ? ColorManager.primary
                      : ColorManager.grey2),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            doctorDatesData!.dayName!,
            style: TextStyle(
                color: LayoutCubit.get(context)
                        .doctorDatesModel!
                        .data![id!]
                        .isVacation!
                    ? ColorManager.white
                    : LayoutCubit.get(context).selectDateIndex == id
                        ? ColorManager.white
                        : ColorManager.grey,
                fontSize: 17.sp,
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 1.h,
          ),
          Text(
            doctorDatesData!.date!.split('-').last.toString(),
            style: TextStyle(
                color: LayoutCubit.get(context)
                        .doctorDatesModel!
                        .data![id!]
                        .isVacation!
                    ? ColorManager.white
                    : LayoutCubit.get(context).selectDateIndex == id
                        ? ColorManager.white
                        : ColorManager.grey,
                fontWeight: FontWeight.w500,
                fontSize: 17.sp),
          ),
        ],
      )),
    );
  }
}
