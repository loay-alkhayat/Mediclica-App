import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:mediclica/resources/color_manager.dart';
import 'package:mediclica/screens/Layout/Bloc/cubit.dart';
import 'package:mediclica/screens/Layout/Bloc/states.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../componnets/my_appoinments_card.dart';

class MyAppointmentScreen extends StatefulWidget {
  const MyAppointmentScreen({Key? key}) : super(key: key);

  @override
  State<MyAppointmentScreen> createState() => _MyAppointmentScreenState();
}

class _MyAppointmentScreenState extends State<MyAppointmentScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _controller.forward();
  }

  void dispose() {
    _controller.dispose(); // Dispose the animation controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    LayoutCubit cubit = LayoutCubit.get(context);
    return BlocConsumer<LayoutCubit, LayoutStates>(
      builder: (context, state) => DefaultTabController(
        initialIndex: cubit.appoinmentIndex,
        animationDuration: const Duration(seconds: 1),
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            forceMaterialTransparency: true,
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(
              "My Appointments",
              style: TextStyle(
                color: ColorManager.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            bottom: TabBar(
              physics: const NeverScrollableScrollPhysics(),
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: ColorManager.primary,
              onTap: (index) {
                cubit.appoinmentIndex = index;
                cubit.myAppointmentModel!.data!.clear();
                cubit.getAppontment(
                    status: cubit.myAppointment[cubit.appoinmentIndex]);
              },
              labelColor: ColorManager.primary,
              unselectedLabelColor: ColorManager.grey,
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              tabs: [
                const Tab(text: 'Upcoming'),
                const Tab(text: 'Completed'),
                const Tab(text: 'Cancelled'),
              ],
            ),
          ),
          body: OverlayLoaderWithAppIcon(
            borderRadius: 90.w,
            appIconSize: 20.w,
            appIcon: ClipRRect(
                borderRadius: BorderRadius.circular(20.w),
                child: Image.asset("assets/Mediclica.jpg")),
            overlayBackgroundColor: ColorManager.lightGrey,
            circularProgressColor: ColorManager.grey,
            isLoading: state is GetAppointmentsLoadingState ||
                state is CancelbookLoadingState,
            child: Container(
              color: Colors.grey[100],
              child: ConditionalBuilder(
                  condition: state is! GetAppointmentsLoadingState,
                  builder: (context) => Padding(
                        padding: EdgeInsets.all(5.w),
                        child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            Column(
                              children: [
                                Expanded(
                                  child:
                                      cubit.myAppointmentModel!.data!.isNotEmpty
                                          ? ListView.builder(
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                return SlideTransition(
                                                  position: Tween<Offset>(
                                                          begin: const Offset(
                                                              0.0, 3.0),
                                                          end: Offset.zero)
                                                      .animate(
                                                    CurvedAnimation(
                                                      parent: _controller,
                                                      curve: Interval(
                                                        (index /
                                                                cubit
                                                                    .myAppointmentModel!
                                                                    .data!
                                                                    .length) *
                                                            0.9, // Adjust the interval as needed
                                                        1.0,
                                                        curve: Curves.easeOut,
                                                      ),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 1.h),
                                                    child: Container(
                                                      height: 24.h,
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4.w),
                                                        color:
                                                            ColorManager.white,
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(4.w),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            MyAppoinmentsCard(
                                                              myAppointmentData: cubit
                                                                  .myAppointmentModel!
                                                                  .data![index],
                                                            ),
                                                            Divider(
                                                              color:
                                                                  ColorManager
                                                                      .grey1,
                                                            ),
                                                            Center(
                                                              child:
                                                                  ElevatedButton(
                                                                      style: ButtonStyle(
                                                                          backgroundColor: WidgetStatePropertyAll(ColorManager
                                                                              .primary)),
                                                                      onPressed:
                                                                          () async {
                                                                        await cubit.cancelBook(
                                                                            bookID:
                                                                                cubit.myAppointmentModel!.data![index].id);
                                                                        cubit.getAppontment(
                                                                            status:
                                                                                cubit.myAppointment[cubit.appoinmentIndex]);
                                                                      },
                                                                      child:
                                                                          const Text(
                                                                        "Cancel Appointment",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                      )),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                              itemCount: cubit
                                                  .myAppointmentModel!
                                                  .data!
                                                  .length)
                                          : Lottie.asset('assets/noitem3.json',
                                              fit: BoxFit.fill,
                                              width: 100.w,
                                              height: 2.h),
                                )
                              ],
                            ),
                            // Content for the "Completed" tab
                            Column(
                              children: [
                                Expanded(
                                  child: cubit
                                          .myAppointmentModel!.data!.isNotEmpty
                                      ? ListView.separated(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return Container(
                                              height: 23.h,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4.w),
                                                color: ColorManager.white,
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(4.w),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Appointment Done",
                                                      style: TextStyle(
                                                          color: ColorManager
                                                              .greenlight,
                                                          fontSize: 16.sp),
                                                    ),
                                                    Text(
                                                      cubit
                                                              .myAppointmentModel!
                                                              .data![index]
                                                              .attributes!
                                                              .startTime! +
                                                          "  |  " +
                                                          cubit
                                                              .myAppointmentModel!
                                                              .data![index]
                                                              .attributes!
                                                              .date!,
                                                      style: TextStyle(
                                                          color:
                                                              ColorManager.grey,
                                                          fontSize: 16.sp),
                                                    ),
                                                    Divider(
                                                      color: ColorManager.grey1,
                                                    ),
                                                    MyAppoinmentsCard(
                                                      myAppointmentData: cubit
                                                          .myAppointmentModel!
                                                          .data![index],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                          separatorBuilder: (context, index) =>
                                              SizedBox(
                                                height: 3.h,
                                              ),
                                          itemCount: cubit
                                              .myAppointmentModel!.data!.length)
                                      : Lottie.asset('assets/noitem3.json',
                                          fit: BoxFit.fill,
                                          width: 100.w,
                                          height: 2.h),
                                )
                              ],
                            ),
                            // Content for the "Cancelled" tab
                            Column(
                              children: [
                                Expanded(
                                  child: cubit
                                          .myAppointmentModel!.data!.isNotEmpty
                                      ? ListView.separated(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          itemBuilder: (context, index) =>
                                              Container(
                                                height: 23.h,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.w),
                                                  color: ColorManager.white,
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(4.w),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Appointment Cancelled",
                                                        style: TextStyle(
                                                            color: ColorManager
                                                                .error,
                                                            fontSize: 16.sp),
                                                      ),
                                                      Text(
                                                        cubit
                                                                .myAppointmentModel!
                                                                .data![index]
                                                                .attributes!
                                                                .startTime! +
                                                            "  |  " +
                                                            cubit
                                                                .myAppointmentModel!
                                                                .data![index]
                                                                .attributes!
                                                                .date!,
                                                        style: TextStyle(
                                                            color: ColorManager
                                                                .grey,
                                                            fontSize: 16.sp),
                                                      ),
                                                      Divider(
                                                        color:
                                                            ColorManager.grey1,
                                                      ),
                                                      MyAppoinmentsCard(
                                                        myAppointmentData: cubit
                                                            .myAppointmentModel!
                                                            .data![index],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                          separatorBuilder: (context, index) =>
                                              SizedBox(
                                                height: 3.h,
                                              ),
                                          itemCount: cubit
                                              .myAppointmentModel!.data!.length)
                                      : Lottie.asset('assets/noitem3.json',
                                          fit: BoxFit.fill,
                                          width: 100.w,
                                          height: 2.h),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                  fallback: (context) => Container()),
            ),
          ),
        ),
      ),
      listener: (context, state) {},
    );
  }
}
