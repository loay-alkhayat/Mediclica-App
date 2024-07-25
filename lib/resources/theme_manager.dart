// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:mediclica/resources/styles_manager.dart';
// import 'package:mediclica/resources/values_manager.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
//
// import 'color_manager.dart';
// import 'fonr_manager.dart';
//
// TextStyle getTextStyle(double fontsize, FontWeight fontWeight, Color color) {
//   return TextStyle(
//       fontSize: fontsize,
//       fontFamily: FontConstants.fontFamily,
//       color: color,
//       fontWeight: fontWeight);
// }
//
// ThemeData getApplicationLightTheme() {
//   return ThemeData(
//     //main Colors
//     primaryColor: ColorManager.primary,
//     brightness: Brightness.light,
//     scaffoldBackgroundColor: ColorManager.white,
//     primaryColorLight: ColorManager.white,
//     primaryColorDark: ColorManager.black, disabledColor: ColorManager.grey1,
//     // splashColor: ColorManager.lightprimary,
//     //Divider Theme
// //     dividerTheme: DividerThemeData(
// //         color: ColorManager.grey2,
// //         thickness: AppSize.s0_5,
// //         space: AppSize.s4,
// //         indent: AppSize.s20.w,
// //         endIndent: AppSize.s20.w),
// //     iconButtonTheme: IconButtonThemeData(
// //       style: ButtonStyle(
// //           elevation: MaterialStatePropertyAll(20),
// //           side: MaterialStatePropertyAll(BorderSide()),
// //           foregroundColor: MaterialStatePropertyAll(ColorManager.primary),
// //           backgroundColor: MaterialStatePropertyAll(ColorManager.primary),
// //           overlayColor: MaterialStatePropertyAll(ColorManager.lightGrey),
// //           iconColor: MaterialStatePropertyAll(ColorManager.white)),
// //     ),
// //     //TextButton Theme
// //     textButtonTheme: TextButtonThemeData(
// //       style: ButtonStyle(
// //         // shape: MaterialStateProperty.all<RoundedRectangleBorder>(
// //         //   RoundedRectangleBorder(
// //         //     borderRadius: BorderRadius.circular(AppSize.s10.w),
// //         //     side: BorderSide(color: ColorManager.primary),
// //         //   ),
// //         // ),
// //         overlayColor: MaterialStatePropertyAll(ColorManager.darkprimary),
// //         backgroundColor: MaterialStatePropertyAll(ColorManager.primary),
// //         textStyle: MaterialStatePropertyAll(
// //           getSemiBoldStyle(fontsize: AppSize.s16.sp, color: ColorManager.white),
// //         ),
// //       ),
// //     ),
// //     //Icon Theme
// //     iconTheme: IconThemeData(
// //       color: ColorManager.black,
// //     ),
// //     //Card Theme
// //     cardTheme: CardTheme(
// //         clipBehavior: Clip.antiAliasWithSaveLayer,
// //         color: ColorManager.white,
// //         elevation: AppSize.s4),
// //
// // //AppBar Theme
// //     appBarTheme: AppBarTheme(
// //       systemOverlayStyle:
// //           SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
// //       color: ColorManager.primary,
// //       iconTheme: IconThemeData(color: ColorManager.white),
// //       actionsIconTheme: IconThemeData(color: ColorManager.white),
// //       elevation: AppSize.s4,
// //       centerTitle: false,
// //       titleSpacing: AppSize.s8,
// //       shadowColor: ColorManager.lightprimary,
// //       titleTextStyle: getRegularStyle(
// //         color: ColorManager.white,
// //         fontsize: FontSize.s22,
// //       ),
// //     ),
// //
// //     //OutLinedButton
// //     outlinedButtonTheme: OutlinedButtonThemeData(
// //         style: ButtonStyle(
// //       side:
// //           MaterialStatePropertyAll(BorderSide(color: ColorManager.lightGrey!)),
// //       overlayColor: MaterialStatePropertyAll(ColorManager.lightGrey),
// //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
// //         RoundedRectangleBorder(
// //           borderRadius: BorderRadius.circular(AppSize.s10.w),
// //         ),
// //       ),
// //     )),
// //
// // //bottomBAr
// //     bottomNavigationBarTheme: BottomNavigationBarThemeData(
// //       type: BottomNavigationBarType.fixed,
// //       selectedItemColor: ColorManager.primary,
// //       unselectedItemColor: ColorManager.grey1,
// //       backgroundColor: ColorManager.white,
// //       elevation: AppSize.s20,
// //     ),
// // //buttonTheme
// //     elevatedButtonTheme: ElevatedButtonThemeData(
// //       style: ElevatedButton.styleFrom(
// //         primary: ColorManager.primary,
// //         shape: RoundedRectangleBorder(
// //           borderRadius: BorderRadius.all(
// //             Radius.circular(AppSize.s12),
// //           ),
// //         ),
// //         textStyle:
// //             getRegularStyle(color: ColorManager.white, fontsize: FontSize.s17),
// //       ),
// //     ),
//
// // text theme
//     textTheme: TextTheme(
//       headlineLarge: TextStyle(
//         fontSize: AppSize.s25,
//         fontFamily: FontConstants.fontFamily,
//       ),
//       bodyLarge: TextStyle(
//         fontWeight: FontWeight.w700,
//         fontSize: AppSize.s18,
//         fontFamily: FontConstants.fontFamily,
//       ),
//       bodyMedium: TextStyle(
//         color: ColorManager.grey,
//         fontSize: AppSize.s17,
//         fontFamily: FontConstants.fontFamily,
//       ),
//       bodySmall: TextStyle(
//         fontSize: AppSize.s16,
//         color: ColorManager.grey,
//         fontFamily: FontConstants.fontFamily,
//       ),
//       displayLarge: TextStyle(
//         fontSize: AppSize.s12,
//         color: ColorManager.grey,
//         fontFamily: FontConstants.fontFamily,
//       ),
//       titleLarge: TextStyle(
//         fontSize: AppSize.s18,
//         color: ColorManager.black,
//         fontFamily: FontConstants.fontFamily,
//       ),
//       titleMedium: TextStyle(
//         fontSize: AppSize.s16,
//         color: ColorManager.grey,
//         fontFamily: FontConstants.fontFamily,
//       ),
//       titleSmall: TextStyle(
//         fontSize: AppSize.s12,
//         fontWeight: FontWeight.w400,
//         color: ColorManager.grey,
//         fontFamily: FontConstants.fontFamily,
//       ),
//     ),
//   );
// }
//
// ThemeData getApplicationDarkTheme() {
//   return ThemeData(
//     //main Colors
//     primaryColor: ColorManager.primary,
//     brightness: Brightness.light,
//     disabledColor: ColorManager.grey1,
//     primaryColorLight: ColorManager.black,
//     primaryColorDark: ColorManager.white,
//     splashColor: ColorManager.lightGrey,
//     scaffoldBackgroundColor: ColorManager.grey1,
//
//     //ICon Theme
//     iconTheme: IconThemeData(
//       color: ColorManager.white,
//     ),
//     //textButton
//     textButtonTheme: TextButtonThemeData(
//       style: ButtonStyle(
//         // shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//         //   RoundedRectangleBorder(
//         //     borderRadius: BorderRadius.circular(AppSize.s10.w),
//         //     side: BorderSide(color: ColorManager.primary),
//         //   ),
//         // ),
//         overlayColor: MaterialStatePropertyAll(ColorManager.darkprimary),
//         // backgroundColor: MaterialStatePropertyAll(ColorManager.primary),
//         textStyle: MaterialStatePropertyAll(
//           getSemiBoldStyle(fontsize: AppSize.s16.sp, color: ColorManager.white),
//         ),
//       ),
//     ),
//     //Card Theme
//     cardTheme: CardTheme(
//         clipBehavior: Clip.antiAliasWithSaveLayer,
//         color: ColorManager.grey2,
//         elevation: AppSize.s8),
//
//     //Divider Theme
//     dividerTheme: DividerThemeData(
//         color: ColorManager.white,
//         thickness: AppSize.s0_5,
//         space: AppSize.s4,
//         indent: AppSize.s20.w,
//         endIndent: AppSize.s20.w),
//
// //AppBar Theme
//     appBarTheme: AppBarTheme(
//       titleSpacing: AppSize.s8,
//       iconTheme: IconThemeData(color: ColorManager.white),
//       actionsIconTheme: IconThemeData(color: ColorManager.white),
//       systemOverlayStyle:
//           SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
//       color: ColorManager.darkprimary,
//       elevation: AppSize.s4,
//       shadowColor: ColorManager.darkprimary,
//       titleTextStyle: getRegularStyle(
//         color: ColorManager.white,
//         fontsize: FontSize.s20,
//       ),
//     ),
//
// //bottomBar
//     bottomNavigationBarTheme: BottomNavigationBarThemeData(
//       type: BottomNavigationBarType.fixed,
//       selectedItemColor: ColorManager.darkprimary,
//       unselectedItemColor: ColorManager.white,
//       backgroundColor: ColorManager.grey2,
//       elevation: AppSize.s12,
//     ),
//     //OutLinedButton
//     outlinedButtonTheme: OutlinedButtonThemeData(
//         style: ButtonStyle(
//       side: MaterialStatePropertyAll(BorderSide(color: ColorManager.darkGrey)),
//       overlayColor: MaterialStatePropertyAll(ColorManager.lightGrey),
//       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//         RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(AppSize.s10.w),
//         ),
//       ),
//     )),
// // text theme
//     textTheme: TextTheme(
//       headlineLarge: getSemiBoldStyle(
//         color: ColorManager.white,
//       ),
//       bodyLarge: getSemiBoldStyle(
//         color: ColorManager.white,
//         fontsize: FontSize.s18,
//       ),
//       bodyMedium: getSemiBoldStyle(
//         color: ColorManager.white,
//         fontsize: FontSize.s16,
//       ),
//       bodySmall: getRegularStyle(
//         color: ColorManager.lightGrey!,
//       ),
//       titleSmall: getRegularStyle(
//         color: ColorManager.white,
//       ),
//       titleMedium: getRegularStyle(
//         color: ColorManager.white,
//         fontsize: FontSize.s16,
//       ),
//       titleLarge: getRegularStyle(
//         color: ColorManager.white,
//         fontsize: FontSize.s18.sp,
//       ),
//       displayLarge: getLightStyle(
//         color: ColorManager.white,
//         fontsize: FontSize.s22,
//       ),
//     ),
//   );
// }
