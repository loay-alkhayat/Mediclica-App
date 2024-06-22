import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mediclica/componnets/doctor_card_widget.dart';
import 'package:mediclica/resources/color_manager.dart';
import 'package:mediclica/resources/values_manager.dart';
import 'package:mediclica/screens/Booking/book_appointment_screen.dart';
import 'package:mediclica/screens/Layout/Bloc/cubit.dart';
import 'package:mediclica/screens/Layout/Bloc/states.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../componnets/button_width.dart';
import '../../componnets/functions.dart';

class DoctorDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LayoutCubit cubit = LayoutCubit.get(context);
    return BlocConsumer<LayoutCubit, LayoutStates>(
      builder: (context, state) => DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
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
                      color: Colors.black,
                    )),
                decoration: BoxDecoration(
                  color: Colors.white70,
                  border: Border.all(color: ColorManager.grey2),
                  borderRadius: BorderRadius.circular(3.w),
                ),
              ),
            ),
            title: cubit.getDoctorDetaielsData
                ? Text(
                    cubit.doctorDetaielsModel!.data!.attributes!.displayName!
                        .toString(),
                    style: TextStyle(
                        color: ColorManager.black, fontWeight: FontWeight.w600),
                  )
                : Container(),
          ),
          body: ConditionalBuilder(
            condition: cubit.getDoctorDetaielsData,
            builder: (context) => Padding(
              padding: EdgeInsets.all(6.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 75.w,
                        child: DoctorCardWidget(
                            doctorDetaielsData:
                                cubit.doctorDetaielsModel!.data),
                      ),
                      Material(
                        elevation: 1.5,
                        borderRadius: BorderRadius.circular(20),
                        child: IconButton(
                          onPressed: () {
                            openDoctorPhoneNumberOnThePhone(cubit
                                .doctorDetaielsModel!
                                .data!
                                .relationships!
                                .user!
                                .phone);
                          },
                          icon: Icon(
                            Icons.call,
                            size: 5.w,
                            color: ColorManager.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color:
                              ColorManager.grey, // Set the color for unselected
                          // tabs
                          width: 0.2.w,
                        ),
                      ),
                    ),
                    child: TabBar(
                      physics: NeverScrollableScrollPhysics(),
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorColor: ColorManager.primary,
                      onTap: (index) {},
                      labelColor: ColorManager.primary,
                      unselectedLabelColor: ColorManager.grey,
                      tabs: [
                        Tab(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(2.w),
                                child: Text(
                                  "About",
                                  maxLines: 1,
                                  strutStyle: StrutStyle(
                                    forceStrutHeight: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Tab(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(2.w),
                                child: Text(
                                  " Location",
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 3.h,
                          ),
                          Text(
                            "About Me",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: AppSize.s18),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            cubit.doctorDetaielsModel!.data!.attributes!.bio
                                .toString(),
                            maxLines: 7,
                            style: TextStyle(
                                color: ColorManager.grey,
                                fontSize: AppSize.s16),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            "Working Time",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: AppSize.s18),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            cubit.doctorDetaielsModel!.data!.relationships!
                                    .workHours!.startHour!
                                    .split(":")
                                    .first +
                                ":00" +
                                " - " +
                                cubit.doctorDetaielsModel!.data!.relationships!
                                    .workHours!.endHour!
                                    .split(":")
                                    .first +
                                ":00",
                            style: TextStyle(
                                color: ColorManager.grey,
                                fontSize: AppSize.s16),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            "Doctor Place",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: AppSize.s18),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            cubit.doctorDetaielsModel!.data!.relationships!
                                .location![0].address!,
                            style: TextStyle(
                                color: ColorManager.grey,
                                fontSize: AppSize.s16),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            width: double.infinity,
                            height: 30.h,
                            margin: EdgeInsets.symmetric(horizontal: 0.095.w),
                            child: GoogleMap(
                              onTap: (latLng) {
                                // String url =
                                //     'https://www.google.com/maps/search/?api=1&query=${cubit.agentDetailsModel!.agentDetails!.latitude!},${cubit.agentDetailsModel!.agentDetails!.longitude!}';
                                // launchUrl(Uri.parse(url));
                              },

                              scrollGesturesEnabled: false,
                              zoomControlsEnabled: false,
                              zoomGesturesEnabled: false,
                              compassEnabled: false,
                              mapToolbarEnabled: false,
                              initialCameraPosition: CameraPosition(
                                target: LatLng(33.510414, 36.278336),
                                // target: LatLng(
                                //     double.parse(cubit
                                //         .doctorDetaielsModel!
                                //         .data!
                                //         .relationships!
                                //         .location![0]
                                //         .lat!),
                                //     double.parse(cubit
                                //         .doctorDetaielsModel!
                                //         .data!
                                //         .relationships!
                                //         .location![0]
                                //         .lng!)),
                                zoom: 15,
                              ),
                              // markers: <marker.Marker>{
                              //   marker.Marker(
                              //     markerId: MarkerId('موقع الطبيب'),
                              //     position: LatLng(
                              //         cubit.agentDetailsModel!.agentDetails!
                              //             .latitude!,
                              //         cubit.agentDetailsModel!.agentDetails!
                              //             .longitude!),
                              //     infoWindow: InfoWindow(
                              //         title:
                              //             '${cubit.agentDetailsModel!.agentDetails!.displayName}',
                              //         snippet:
                              //             '${cubit.agentDetailsModel!.agentDetails!.category}'),
                              //   ),
                              // },
                            ),
                          ),
                        ],
                      ),
                    ]),
                  ),
                ],
              ),
            ),
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.all(4.w),
            child: Row(
              children: [
                widthButton(
                  textButton: "Make An Appointment",
                  onPress: () async {
                    cubit.getDoctorServices(
                      doctorID: cubit.doctorDetaielsModel!.data!.id!,
                    );
                    cubit.getDoctorDates(
                      doctorID: cubit.doctorDetaielsModel!.data!.id!,
                    );
                    Functions.navigatorPush(context, BookAppointmentScreen());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      listener: (context, state) {},
    );
  }
}

void openDoctorPhoneNumberOnThePhone(phoneNumber) {
  launchUrlString('tel:$phoneNumber');
}
