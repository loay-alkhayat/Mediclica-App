// import 'package:flutter/material.dart';
// import 'package:mediclica/resources/color_manager.dart';
// import 'package:mediclica/resources/fonr_manager.dart';
// import 'package:mediclica/screens/OnBoarding/get_started_screen.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
//
// class SplashScreen extends StatelessWidget {
//   const SplashScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     Future.delayed(Duration(seconds: 2), () {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(
//           builder: (context) => GetStartedScreen(),
//         ),
//       );
//     });
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Center(
//               child: Text(
//             "Mediclica",
//             style: TextStyle(
//                 color: ColorManager.grey,
//                 fontSize: 30.sp,
//                 fontFamily: FontConstants.fontFamily),
//           )),
//         ],
//       ),
//     );
//   }
// }
