import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mediclica/resources/color_manager.dart';
import 'package:mediclica/screens/Centers/centers_screen.dart';
import 'package:mediclica/screens/Layout/Bloc/cubit.dart';
import 'package:mediclica/screens/Profile/my_profile_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../Appointments/my_appointments_screen.dart';
import '../Doctor/doctors_screen.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static int _bottomNavIndex = 0;
  late PageController _pageController;

  final List<Widget> pages = [
    const HomeScreen(),
    DoctorsScreen(),
    CentersScreen(),
    const MyAppointmentScreen(),
    const MyProfileScreen(),
  ];
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _bottomNavIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        scrollBehavior: const ScrollBehavior(),
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        itemCount: 5,
        itemBuilder: (context, index) {
          return AnimatedOpacity(
            opacity: index == _bottomNavIndex ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 2000),
            child: pages[index],
          );
        },
        onPageChanged: (index) {
          setState(() {
            _bottomNavIndex = index;
          });
        },
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: const [
          Icons.home_outlined,
          Icons.person_search,
          Icons.local_hospital,
          Icons.calendar_month_outlined,
          Icons.person,
        ],
        activeColor: ColorManager.primary,
        activeIndex: _bottomNavIndex,
        gapWidth: 2.w,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastLinearToSlowEaseIn,
          );
          if (index == 1) {
            // if (LayoutCubit.get(context).getDoctorModel!.data!.isEmpty)

            LayoutCubit.get(context).pager = 1;
            LayoutCubit.get(context).getDoctors();
          }
          if (index == 2) {
            LayoutCubit.get(context).centersPager = 1;
            LayoutCubit.get(context).getCenters();
          }
          if (index == 3) {
            // if (LayoutCubit.get(context).getDoctorModel!.data!.isEmpty)

            LayoutCubit.get(context).getAppontment(
                status: LayoutCubit.get(context)
                    .myAppointment[LayoutCubit.get(context).appoinmentIndex]);
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
