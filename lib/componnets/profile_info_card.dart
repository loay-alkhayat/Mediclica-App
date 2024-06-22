import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../resources/color_manager.dart';

class ProfileInfoCard extends StatelessWidget {
  IconData icona;
  Color iconColor;
  String txt;

  ProfileInfoCard(
      {required this.icona,
      required this.iconColor,
      required this.txt,
      this.onPress});
  VoidCallback? onPress;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: ColorManager.grey2,
      overlayColor: MaterialStatePropertyAll(ColorManager.grey2),
      borderRadius: BorderRadius.circular(2.w),
      onTap: onPress,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 7.w),
            child: Container(
              width: double.infinity,
              height: 7.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.w),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    icona,
                    color: iconColor,
                  ),
                  SizedBox(
                    width: 3.w,
                  ),
                  Text("$txt"),
                ],
              ),
            ),
          ),
          Divider(
            color: ColorManager.lightGrey,
            endIndent: 6.w,
            indent: 6.w,
          ),
        ],
      ),
    );
  }
}
