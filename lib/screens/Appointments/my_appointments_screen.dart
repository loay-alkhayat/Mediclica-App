import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyAppointmentScreen extends StatelessWidget {
  const MyAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "MyAppointmentScreen",
          style: TextStyle(fontSize: 20.sp),
        ),
      ),
    );
  }
}
