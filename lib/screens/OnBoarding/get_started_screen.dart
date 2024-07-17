import 'package:flutter/material.dart';
import 'package:mediclica/componnets/button_width.dart';
import 'package:mediclica/resources/color_manager.dart';
import 'package:mediclica/screens/Auth/login_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../componnets/functions.dart';

class GetStartedScreen extends StatelessWidget {
  GetStartedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(10.w),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Mediclica",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: ColorManager.primary),
                  ),
                  ShaderMask(
                    shaderCallback: (rect) {
                      return const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          // fromLTRB
                          Colors.black,
                          Colors.black,
                          Colors.black,
                          Colors.transparent,
                        ],
                        stops: [0, 0.4, 0.4, 0.9],
                      ).createShader(
                        Rect.fromLTRB(0, 0, rect.width, rect.height),
                      );
                    },
                    blendMode: BlendMode.dstIn,
                    child: Image.asset(
                      "assets/mage.png",
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      textAlign: TextAlign.center,
                      "Best Doctor Appointment App",
                      style: TextStyle(
                          fontSize: 20.sp, color: ColorManager.primary),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Text(
                      "Manage and schedule all of your medical appointments "
                      "easily with Mediclica to get a new experience.",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 16.sp, color: ColorManager.grey),
                    ),
                  ),
                  Row(
                    children: [
                      widthButton(
                        textButton: "Get Started",
                        onPress: () {
                          Functions.navigatorPush(context, LoginScreen());
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
