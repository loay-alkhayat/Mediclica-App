import 'package:flutter/material.dart';
import 'package:mediclica/componnets/doctor_card_widget.dart';
import 'package:mediclica/componnets/functions.dart';
import 'package:mediclica/resources/color_manager.dart';
import 'package:mediclica/screens/Doctor/doctor_details.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NearbyDoctorScreen extends StatelessWidget {
  const NearbyDoctorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: EdgeInsets.all(1.w),
          child: Container(
            height: 6.h,
            width: 12.w,
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  size: 5.w,
                )),
            decoration: BoxDecoration(
              color: Colors.white70,
              border: Border.all(color: ColorManager.grey2),
              borderRadius: BorderRadius.circular(3.w),
            ),
          ),
        ),
        title: Text(
          "Nearby Doctors",
          style: TextStyle(color: ColorManager.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(5.w),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => InkWell(
                      overlayColor:
                          MaterialStatePropertyAll(ColorManager.lightGrey),
                      borderRadius: BorderRadius.circular(18),
                      onTap: () {
                        Functions.navigatorPush(context, DoctorDetailsScreen());
                      },
                      child: DoctorCardWidget()),
                  separatorBuilder: (context, index) => Divider(
                        color: ColorManager.grey1,
                      ),
                  itemCount: 10),
            )
          ],
        ),
      ),
    );
  }
}
