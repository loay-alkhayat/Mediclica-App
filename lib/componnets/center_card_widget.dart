import 'package:flutter/material.dart';
import 'package:mediclica/models/MainScreensModels/centers_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../resources/color_manager.dart';

class CenterCardWidget extends StatelessWidget {
  CenterCardWidget({super.key, this.centersData});
  CentersData? centersData;
  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.h),
            ),
            height: 11.h,
            width: double.infinity,
            child: ClipRRect(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                borderRadius: BorderRadius.circular(2),
                child: Image.asset(
                  'assets/center.jpg',
                  fit: BoxFit.cover,
                )),
          ),
          Text(
            centersData!.attributes!.name!,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17.sp),
          ),
          SizedBox(
            height: 1.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                centersData!.relationships!.categories![0].name!,
                style: TextStyle(color: ColorManager.grey),
              ),
              Text(
                "|",
                style: TextStyle(color: ColorManager.grey),
              ),
              Text(
                centersData!.relationships!.location != null
                    ? centersData!.relationships!.location!.address!
                    : "Midan",
                style: TextStyle(color: ColorManager.grey),
              ),
            ],
          ),
          SizedBox(
            height: 0.5.h,
          ),
          // Text(
          //   "Location",
          //   style: TextStyle(color: ColorManager.grey),
          // ),
        ],
      ),
    );
  }
}
