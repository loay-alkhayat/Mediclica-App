import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mediclica/resources/color_manager.dart';

void showToast({
  required String message,
  Color? color,
  Color? textColor,
}) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: color ?? ColorManager.black,
    textColor: textColor ?? ColorManager.white,
    fontSize: 14,
  );
}
