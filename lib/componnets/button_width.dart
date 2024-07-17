import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../resources/color_manager.dart';

class widthButton extends StatelessWidget {
  String textButton;
  VoidCallback? onPress;

  widthButton({
    super.key,
    required this.textButton,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(
            EdgeInsets.all(4.w),
          ),
          backgroundColor:
              MaterialStateProperty.all<Color>(ColorManager.primary),
          foregroundColor: MaterialStateProperty.all<Color>(ColorManager.grey1),
          overlayColor: MaterialStateProperty.all(ColorManager.primary),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3.w),
              side: BorderSide(color: ColorManager.primary),
            ),
          ),
        ),
        onPressed: onPress,
        child: Text(
          textButton,
          style: TextStyle(
              color: ColorManager.white,
              fontWeight: FontWeight.bold,
              fontSize: 17.sp),
        ),
      ),
    );
  }
}
