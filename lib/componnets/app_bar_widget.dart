import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../resources/color_manager.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  AppBarWidget({
    Key? key,
    this.actions,
    this.leading,
    this.title,
    this.centerTitle,
  }) : super(key: key);

  final Widget? leading;
  String? title = '';
  bool? centerTitle = false;
  List<Widget>? actions = [];

  Size get preferredSize => Size.fromHeight(56);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: actions!,
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
        "$title",
        style:
            TextStyle(color: ColorManager.black, fontWeight: FontWeight.w600),
      ),
    );
  }
}
