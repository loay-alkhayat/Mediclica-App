import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediclica/core/constants/apis_url.dart';
import 'package:mediclica/core/services/cache_storage_services.dart';
import 'package:mediclica/core/services/dio_services.dart';
import 'package:mediclica/models/MainScreensModels/categories_model.dart';
import 'package:mediclica/models/MainScreensModels/get_doctors_model.dart';
import 'package:mediclica/screens/Layout/Bloc/states.dart';

import '../../../models/MainScreensModels/profile_model.dart';

class LayoutCubit extends Cubit<LayoutStates> {
  LayoutCubit() : super(LayoutInitialState());
  static LayoutCubit get(context) => BlocProvider.of(context);

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

  ///DoctorsScreen
  GetDoctorModel? getDoctorModel;
  bool getDoctorsData = false;
  List<GetDoctorsData> doctors = [];
  Future<void> getDoctors() async {
    emit(LayoutGetDoctorsLoadingState());
    try {
      final value = await DioServices().get(url: ApiUrls.doctors + "?page=1");
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

  ///logOut
  Future<void> logOut() async {
    DioServices().post(url: ApiUrls.logOut, headers: {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${CacheHelper.getData(key: "barrierToken")}'
    });
  }
}
