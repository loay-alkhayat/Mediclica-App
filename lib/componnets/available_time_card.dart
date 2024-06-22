import 'package:flutter/material.dart';
import 'package:mediclica/screens/Layout/Bloc/cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../resources/color_manager.dart';

class AviliableTimeCard extends StatelessWidget {
  AviliableTimeCard({super.key, required this.index});
  bool avilable = false;
  int? index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      height: 7.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(4.w),
        ),
        color: LayoutCubit.get(context)
                .doctorWorkHoursModel!
                .data![index!]
                .available!
            ? LayoutCubit.get(context).selectTimeIndex == index
                ? ColorManager.primary
                : ColorManager.grey2
            : ColorManager.darkGrey,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            LayoutCubit.get(context)
                .doctorWorkHoursModel!
                .data![index!]
                .hour!
                .toString(),
            style: TextStyle(
                color: LayoutCubit.get(context)
                        .doctorWorkHoursModel!
                        .data![index!]
                        .available!
                    ? LayoutCubit.get(context).selectTimeIndex == index
                        ? ColorManager.white
                        : ColorManager.grey
                    : ColorManager.white,
                fontWeight: FontWeight.w500,
                fontSize: 17.sp),
          ),
        ],
      ),
    );
  }
}
