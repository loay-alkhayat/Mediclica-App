import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediclica/componnets/show_toast.dart';
import 'package:mediclica/screens/Layout/Bloc/cubit.dart';
import 'package:mediclica/screens/Layout/Bloc/states.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../componnets/button_width.dart';
import '../../componnets/functions.dart';
import '../../resources/color_manager.dart';
import '../Booking/book_appointment_screen.dart';

class CenterDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LayoutCubit cubit = LayoutCubit.get(context);

    return BlocConsumer<LayoutCubit, LayoutStates>(
      builder: (context, state) => DefaultTabController(
        length: 2,
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: Column(
              children: [
                buildCenterImage(cubit),
                buildTabBar(),
                Expanded(
                  child: buildTabBarView(cubit, state),
                ),
              ],
            ),
          ),
          bottomNavigationBar: buildBottomNavigationBar(context, cubit),
        ),
      ),
      listener: (context, state) {},
    );
  }

  Widget buildCenterImage(LayoutCubit cubit) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.h),
          ),
          height: 17.h,
          width: double.infinity,
          child: ClipRRect(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            borderRadius: BorderRadius.circular(2),
            child: Image.asset(
              'assets/center.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 8.5.h, right: 7.w),
          child: Container(
            color: ColorManager.primary,
            width: 30.w,
            height: 3.5.h,
            child: Center(
              child: Text(
                cubit.centerDetaielsModel!.data!.attributes!.name!,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTabBar() {
    return Column(
      children: [
        TabBar(
          physics: const NeverScrollableScrollPhysics(),
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorColor: ColorManager.primary,
          onTap: (index) {},
          labelColor: ColorManager.primary,
          unselectedLabelColor: ColorManager.grey,
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          tabs: const [
            Tab(text: "About Us"),
            Tab(text: "Our Services"),
          ],
        ),
      ],
    );
  }

  Widget buildTabBarView(LayoutCubit cubit, LayoutStates state) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: TabBarView(
        children: [
          SingleChildScrollView(
            child: buildAboutUsContent(cubit),
          ),
          buildOurServicesContent(cubit, state),
        ],
      ),
    );
  }

  Widget buildAboutUsContent(LayoutCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 3.h),
        Text(
          cubit.centerDetaielsModel!.data!.attributes!.bio!,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
            color: ColorManager.grey1,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          "Our Information:",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
        SizedBox(height: 2.h),
        buildContactInfo(cubit),
      ],
    );
  }

  Widget buildContactInfo(LayoutCubit cubit) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      overlayColor: MaterialStateProperty.all(ColorManager.lightGrey),
      onTap: () {},
      child: Row(
        children: [
          CircleAvatar(
            child: Icon(
              Icons.phone,
              size: 5.w,
              color: ColorManager.primary,
            ),
            backgroundColor: ColorManager.lightprimary,
            radius: 17,
          ),
          SizedBox(width: 2.w),
          Text(
            cubit.centerDetaielsModel!.data!.relationships!.user!.phone!,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOurServicesContent(LayoutCubit cubit, LayoutStates state) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) =>
                buildExpansionPanelList(cubit, index, state),
            separatorBuilder: (context, index) => SizedBox(height: 2.h),
            itemCount: cubit
                .centerDetaielsModel!.data!.relationships!.categories!.length,
          ),
        ),
      ],
    );
  }

  Widget buildExpansionPanelList(
      LayoutCubit cubit, int index, LayoutStates state) {
    return ExpansionPanelList(
      animationDuration: const Duration(seconds: 1),
      dividerColor: ColorManager.lightGrey,
      elevation: 2,
      expandedHeaderPadding: const EdgeInsets.all(0),
      materialGapSize: 4.h,
      expansionCallback: (int panelIndex, bool isExpanded) {
        cubit.changeExpanded(expanded: isExpanded);

        if (isExpanded) {
          cubit.getDoctorByCatId(
            centerID: cubit.centerDetaielsModel!.data!.id!,
            categoryID: cubit.centerDetaielsModel!.data!.relationships!
                .categories![index].id!,
          );
        } else {
          cubit.resetDoctorSelection();
        }
      },
      children: [
        ExpansionPanel(
          backgroundColor: ColorManager.white,
          canTapOnHeader: true,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(cubit.centerDetaielsModel!.data!.relationships!
                  .categories![index].name!),
            );
          },
          body: buildDoctorList(cubit, state),
          isExpanded: cubit.expand,
        ),
      ],
    );
  }

  Widget buildDoctorList(LayoutCubit cubit, LayoutStates state) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: Container(
        width: double.infinity,
        height: 10.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return buildDoctorItem(cubit, index, state);
          },
          separatorBuilder: (context, index) => const SizedBox(width: 10.0),
          itemCount: cubit.centerDoctorsByGategoryModel!.data!.length,
        ),
      ),
    );
  }

  Widget buildDoctorItem(LayoutCubit cubit, int index, LayoutStates state) {
    return state is GetCenterDoctorLoadingState
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(25),
                onTap: () {
                  cubit.doctorInCenterId =
                      cubit.centerDoctorsByGategoryModel!.data![index].id!;
                  cubit.doctorINdex = index;
                  cubit.changeTapped(index: index);
                  cubit.elementTaped = true;
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    color: cubit.doctorincenterIndex == index
                        ? ColorManager.primary
                        : Colors.white,
                    child: CircleAvatar(
                      backgroundColor: cubit.boolList[index] == true
                          ? ColorManager.primary
                          : ColorManager.white,
                      backgroundImage: NetworkImage(
                          "https://medical.alhasanshnnar.com/${cubit.centerDoctorsByGategoryModel!.data![index].attributes!.image}"),
                      radius: 7.w,
                    ),
                  ),
                ),
              ),
              Text(
                cubit.centerDoctorsByGategoryModel!.data![index].attributes!
                    .displayName!,
                style: const TextStyle(),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ],
          );
  }

  Widget buildBottomNavigationBar(BuildContext context, LayoutCubit cubit) {
    return Padding(
      padding: EdgeInsets.all(4.w),
      child: Row(
        children: [
          widthButton(
            textButton: "Make An Appointment",
            onPress: () async {
              if (cubit.centerDoctorsByGategoryModel!.message ==
                  "No Work Hours for this doctor") {
                showToast(message: "NoTimesForThisDoctor");
              } else if (cubit.elementTaped == true) {
                cubit.getDoctorDetaiels(
                    doctorID: cubit.centerDoctorsByGategoryModel!
                        .data![cubit.doctorINdex].id!);
                cubit.getDoctorDates(
                    doctorID: cubit.centerDoctorsByGategoryModel!
                        .data![cubit.doctorINdex].id!,
                    centerID: cubit.centerDetaielsModel!.data!.id!);
                cubit.getDoctorServices(
                    doctorID: cubit.centerDoctorsByGategoryModel!
                        .data![cubit.doctorINdex].id!);
                Functions.navigatorPush(
                    context,
                    BookAppointmentScreen(
                        doctorDatesModel: cubit.doctorDatesModel));
                cubit.resetDoctorSelection();
                cubit.changeExpanded(expanded: false);
              } else {
                showToast(message: "PleaseSelectDoctor");
              }
            },
          ),
        ],
      ),
    );
  }
}
