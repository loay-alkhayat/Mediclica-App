import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediclica/core/constants/apis_url.dart';
import 'package:mediclica/core/services/cache_storage_services.dart';
import 'package:mediclica/core/services/dio_services.dart';
import 'package:mediclica/models/CenterScreensModels/center_detaiels_model.dart';
import 'package:mediclica/models/DoctorsScreensModels/book_appointment_model.dart';
import 'package:mediclica/models/DoctorsScreensModels/doctor_detaiels_model.dart';
import 'package:mediclica/models/DoctorsScreensModels/doctor_workhours_model.dart';
import 'package:mediclica/models/DoctorsScreensModels/search_doctor_model.dart';
import 'package:mediclica/models/MainScreensModels/ai_model.dart';
import 'package:mediclica/models/MainScreensModels/categories_model.dart';
import 'package:mediclica/models/MainScreensModels/centers_model.dart';
import 'package:mediclica/models/MainScreensModels/get_doctors_model.dart';
import 'package:mediclica/models/MainScreensModels/my_appointment_model.dart';
import 'package:mediclica/screens/Layout/Bloc/states.dart';

import '../../../models/CenterScreensModels/center_doctors_by_category_model.dart';
import '../../../models/DoctorsScreensModels/doctor_dates_model.dart';
import '../../../models/DoctorsScreensModels/doctor_services_model.dart';
import '../../../models/MainScreensModels/profile_model.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(LayoutInitialState());
  static LayoutCubit get(context) => BlocProvider.of(context);

  ///MainScreen
  ///CategoriesApi
  CategoriesModel? categoriesModel;
  bool getCategoriesData = false;
  Future<void> getCategories() async {
    emit(LayoutGetCategoriesLoadingState());
    await DioServices().get(url: ApiUrls.categories).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      print(value.data);
      getCategoriesData = true;
      emit(LayoutGetCategoriesSucsessState());
    }).catchError((error) {
      logger.d(error.toString());
      emit(LayoutGetCategoriesErrorState());
    });
  }

  ///ProfileScreen
  ProfileModel? profileModel;
  bool getProfileData = false;
  Future<void> getProfile() async {
    emit(LayoutGetProfileLoadingState());
    await DioServices().get(url: ApiUrls.profile).then((value) {
      profileModel = ProfileModel.fromJson(value.data);
      getProfileData = true;
      emit(LayoutGetProfileSucsessState());
    }).catchError((error) {
      logger.d(error.toString());
      emit(LayoutGetProfileErrorState());
    });
  }

  ///MyAppoinmentScreen
  List myAppointment = ['pending', 'accepted', 'cancelled'];
  int appoinmentIndex = 0;
  MyAppointmentModel? myAppointmentModel;
  Future<void> getAppontment({
    required String status,
  }) async {
    emit(GetAppointmentsLoadingState());
    await DioServices().get(url: ApiUrls.userAppointment, query: {
      'status': status,
    }).then((value) {
      myAppointmentModel = MyAppointmentModel.fromJson(value.data);
      print(myAppointmentModel!.data![3].id);
      emit(GetAppointmentsSucsessState());
    }).catchError((onError) {
      logger.d(onError);
      emit(GetAppointmentsErrorState());
    });
  }

  ///CentersScreens

  ScrollController? scrollCentersController;
  CentersModel? centersModel;
  int centersPager = 1;
  bool getCentersData = false;
  int centerID = 0;
  int doctorInCenterId = 0;
  List<bool> boolList = [];
  Future<void> getCenters() async {
    emit(GetCentersLoadingState());
    if (scrollCentersController == null) {
      scrollCentersController = ScrollController();
      scrollCentersController!.addListener(scrollCentersListener);
    }
    try {
      final value =
          await DioServices().get(url: ApiUrls.centers + "?page=$centersPager");
      centersModel = CentersModel.fromJson(value.data);
      getCentersData = true;

      emit(GetCentersSucsessState());
    } catch (error) {
      getCentersData = false;
      logger.d(error);
      emit(GetCentersErrorState());
    }
  }

  void scrollCentersListener() {
    if (scrollCentersController!.position.maxScrollExtent ==
        scrollCentersController!.position.pixels) {
      {
        if (pager < centersModel!.message!) {
          pager++;
          getCenters();
        }
      }
    }
  }

  CenterDetaielsModel? centerDetaielsModel;
  Future<void> getCenterById({required int centerID}) async {
    emit(GetCenterDetaielsLoadingState());
    await DioServices()
        .get(url: ApiUrls.centerDetail + "/$centerID")
        .then((value) {
      centerDetaielsModel = CenterDetaielsModel.fromJson(value.data);
      emit(GetCenterDetaielsSucsessState());
    }).catchError((onError) {
      logger.d(onError);
      emit(GetCenterDetaielsErrorState());
    });
  }

  bool getdoctorCategories = false;
  CenterDoctorsByGategoryModel? centerDoctorsByGategoryModel;
  Future<void> getDoctorByCatId(
      {required int centerID, required int categoryID}) async {
    emit(GetCenterDoctorLoadingState());
    await DioServices()
        .get(url: ApiUrls.centerDetail + "/$centerID/$categoryID")
        .then((value) {
      centerDoctorsByGategoryModel =
          CenterDoctorsByGategoryModel.fromJson(value.data);
      boolList =
          List<bool>.filled(centerDoctorsByGategoryModel!.data!.length, false);
      print(value);
      getdoctorCategories = true;
      emit(GetCenterDoctorSucsessState());
    }).catchError((onError) {
      logger.d(onError);
      emit(GetCenterDoctorErrorState());
    });
  }

  bool elementTaped = false;
  int doctorINdex = 0;
  bool expand = false;
  void changeExpanded({required bool expanded}) {
    expand = expanded;
    emit(ChangeExpandedState());
  }

  ///DoctorsScreen
  int pager = 1;
  ScrollController? scrollController;
  GetDoctorModel? getDoctorModel;
  bool getDoctorsData = false;
  List<GetDoctorsData> doctors = [];
  Future<void> getDoctors() async {
    emit(LayoutGetDoctorsLoadingState());
    if (scrollController == null) {
      scrollController = ScrollController();
      scrollController!.addListener(_scrollListener);
    }
    try {
      final value =
          await DioServices().get(url: ApiUrls.doctors + "?page=$pager");
      getDoctorModel = GetDoctorModel.fromJson(value.data);
      getDoctorsData = true;
      doctors.addAll(getDoctorModel!.data!);
      emit(LayoutGetDoctorsSucsessState());
    } catch (error) {
      getDoctorsData = false;
      logger.d(error);
      emit(LayoutGetDoctorsErrorState());
    }
  }

  void _scrollListener() {
    if (scrollController!.position.pixels ==
        scrollController!.position.maxScrollExtent) {
      {
        if (pager < getDoctorModel!.message!) {
          pager++;
          getDoctors();
        }
      }
    }
  }

  ///DoctorDetaielsScreen
  DoctorDetaielsModel? doctorDetaielsModel;
  bool getDoctorDetaielsData = false;
  Future<void> getDoctorDetaiels({required int doctorID}) async {
    getDoctorDetaielsData = false;
    emit(GetDoctorDetaielsLoadingState());
    await DioServices()
        .get(url: ApiUrls.doctorDetaiels + "/$doctorID")
        .then((value) {
      doctorDetaielsModel = DoctorDetaielsModel.fromJson(value.data);
      print(value.data);
      getDoctorDetaielsData = true;
      emit(GetDoctorDetaielsSucsessState());
    }).catchError((onError) {
      logger.d(onError);
      getDoctorDetaielsData = false;
      emit(GetDoctorDetaielsErrorState());
    });
  }

  ///DoctorBookingScreens
  DoctorServicesModel? doctorServicesModel;
  bool getServicesData = false;
  Future<void> getDoctorServices({required int doctorID}) async {
    emit(GetDoctorServicesLoadingState());
    await DioServices().get(url: ApiUrls.doctorServices, query: {
      "doctor_id": doctorID,
    }).then((value) {
      doctorServicesModel = DoctorServicesModel.fromJson(value.data);
      getServicesData = true;
      print(value.data);
      emit(GetDoctorServicesSucsessState());
    }).catchError((onError) {
      logger.d(onError);
      emit(GetDoctorServicesErrorState());
    });
  }

  DoctorDatesModel? doctorDatesModel;
  bool getDoctorDatesData = false;
  Future<void> getDoctorDates({required int doctorID, int? centerID}) async {
    emit(GetDoctorDatesLoadingState());
    await DioServices().get(
        url: ApiUrls.doctorDates,
        query: {"doctor_id": doctorID, "center_id": centerID}).then((value) {
      doctorDatesModel = DoctorDatesModel.fromJson(value.data);
      print(value);
      getDoctorDatesData = true;
      emit(GetDoctorDatesSucsessState());
    }).catchError((onError) {
      logger.d(onError);
      emit(GetDoctorDatesErrorState());
    });
  }

  DoctorWorkHoursModel? doctorWorkHoursModel;
  bool getworkhoursData = false;
  Future<void> getDoctorWorkHours(
      {required int doctorID,
      required int serviceId,
      required String date,
      int? centerID}) async {
    getworkhoursData = false;
    emit(GetDoctorWorkHoursLoadingState());
    await DioServices().get(url: ApiUrls.doctorWorkHour, query: {
      "doctor_id": doctorID,
      "service_id": serviceId,
      "date": date,
      "center_id": centerID
    }).then((value) {
      getworkhoursData = true;
      doctorWorkHoursModel = DoctorWorkHoursModel.fromJson(value.data);
      print(value.data);
      emit(GetDoctorWorkHoursSucsessState());
    }).catchError((onError) {
      logger.d(onError);
      emit(GetDoctorWorkHoursErrorState());
    });
  }

  BookAppointmentModel? bookAppointmentModel;
  Future<void> bookAppointment(
      {required int doctorID,
      required int serviceId,
      required String date,
      required String hour,
      int? centerID}) async {
    emit(MakeAppointmentLoadingState());
    await DioServices().post(url: ApiUrls.appointment, data: {
      "doctor_id": doctorID,
      "service_id": serviceId,
      "start_date": date,
      'start_time': hour,
      'center_id': centerID
    }, headers: {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${CacheHelper.getData(key: "barrierToken")}',
    }).then((value) {
      bookAppointmentModel = BookAppointmentModel.fromJson(value.data);

      emit(MakeAppointmentSucsessState());
    }).catchError((onError) {
      logger.d(onError);
      emit(MakeAppointmentErrorState());
    });
  }

  ///ChangeButtonsAppoinmentScreen
  int serviceid = 0;

  int? selectIndex;
  bool serviceActive = false;
  void serviceStatus(int index) {
    emit(ChangeServicefalseState());
    selectIndex = index;
    serviceid = doctorServicesModel!.data![index].id!;
    serviceActive = true;
    emit(ChangeServiceState());
  }

  void SearchserviceStatus(int index) {
    emit(ChangeServicefalseState());
    selectIndex = index;

    emit(ChangeServiceState());
  }

  String? dateSelected;
  bool dateActive = false;
  int? selectDateIndex;
  void dateStatus(int index) {
    emit(ChangedatefalseState());
    selectDateIndex = index;
    dateSelected = doctorDatesModel!.data![index].date;
    dateActive = true;
    print(doctorDatesModel!.data![index].date);
    emit(ChangedateState());
  }

  bool timeActive = false;
  String? workHourSelected;
  int? selectTimeIndex;
  bool changedTime = false;
  void timeStatus(int index) {
    emit(ChangetimefalseState());
    selectTimeIndex = index;
    timeActive = true;
    changedTime = true;
    workHourSelected = doctorWorkHoursModel!.data![index].hour;
    emit(ChangetimeState());
  }

  int? doctorincenterIndex;
  void changeTapped({int? index}) {
    emit(ChangefalsetppedState());
    boolList[index!] = !boolList[index];
    doctorincenterIndex = index;
    emit(ChangetppedState());
  }

  ///SearchDoctor
  SearchDoctorModel? searchDoctorModel;
  bool anyDoctorsSearchResult = false;
  Future<void> searchDoctors({String? doctorName, int? category}) async {
    anyDoctorsSearchResult = false;
    emit(SearchDoctorLoadingState());
    await DioServices().get(
        url: ApiUrls.searchDoctors,
        query: {'name': doctorName, 'category_id': category}).then((value) {
      searchDoctorModel = SearchDoctorModel.fromJson(value.data);
      anyDoctorsSearchResult = true;
      emit(SearchDoctorSucsessState());
    }).catchError((onError) {
      logger.d(onError);
      emit(SearchDoctorErrorState());
    });
  }

  ///AI
  AIModel? aiModel;
  int? aiIndex;
  Future<void> aiRecom({required List reco}) async {
    emit(GetAiLoadingState());
    await DioServices().post(url: ApiUrls.ai, data: {
      'symptoms': reco
    }, headers: {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${CacheHelper.getData(key: "barrierToken")}',
    }).then((value) {
      aiModel = AIModel.fromJson(value.data);

      emit(GetAiSucsessState());
    }).catchError((onError) {
      logger.d(onError);
      emit(GetAiErrorState());
    });
  }

  ///logOut
  Future<void> logOut() async {
    DioServices().post(url: ApiUrls.logOut, headers: {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${CacheHelper.getData(key: "barrierToken")}'
    });
  }

  ///cancelBook
  Future<void> cancelBook({required bookID}) async {
    emit(CancelbookLoadingState());
    await DioServices().post(
        url: '${ApiUrls.cancelBook}?booking_id=$bookID&status=cancelled',
        headers: {
          'lang': 'en',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${CacheHelper.getData(key: "barrierToken")}',
        }).then((value) {
      emit(CancelbookLoadingState());
    }).catchError((onError) {
      print(onError);
      emit(CancelbookErrorState());
    });
  }
}
