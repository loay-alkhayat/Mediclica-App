import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mediclica/core/constants/apis_url.dart';
import 'package:mediclica/core/services/cache_storage_services.dart';
import 'package:mediclica/core/services/dio_services.dart';
import 'package:mediclica/models/AuthModels/register_model.dart';
import 'package:mediclica/screens/Auth/bloc/states.dart';

import '../../../models/AuthModels/login_model.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialState());
  static AuthCubit get(context) => BlocProvider.of(context);

  final TextEditingController firstname = TextEditingController();
  final TextEditingController lastname = TextEditingController();
  final TextEditingController phonenumber = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repasswordController = TextEditingController();

  ///RegisterScreen
  RegisterModel? registerModel;
  Future register({
    required String? email,
    required String firstname,
    required String gender,
    required String lastname,
    required String phone,
    String? token,
    required String password,
    required String confirmPassword,
    required String birthDay,
    required String userImage,
  }) async {
    emit(RegisterLoadingState());
    await DioServices().post(
      url: ApiUrls.register,
      data: {
        'email': email,
        'gender': gender,
        'display_name': firstname + lastname,
        'first_name': firstname,
        "last_name": lastname,
        "phone": phone,
        "fcm_token": "asdsdaadw24252wwssad53",
        'password': password,
        'password_confirmation': confirmPassword,
        'birth_date': birthDay,
        'role': 'client',
        'image': userImage,
      },
    ).then((value) {
      registerModel = RegisterModel.fromJson(value.data);

      CacheHelper.saveData(
          key: "barrierToken", value: registerModel!.data!.token.toString());

      emit(RegisterSucssesState());
    }).catchError((error) {
      logger.i(error);
      emit(RegisterErrorState());
    });
  }

  ///ContinueUserInformation
  String gender = "";
  bool selectGender = false;
  CheckGender(var value) {
    gender = value;
    selectGender = !selectGender;
    selectGender == true
        ? emit(UserContinueInfoCheckGenderState())
        : emit(UserContinueInfoCheckGender2State());
  }

  String userBirthday = '2010/10/16';
  bool selectBirhday = false;
  void setBirthday(DateTime? birthday) {
    userBirthday = DateFormat('yyyy-MM-dd').format(birthday!).toString();
    selectBirhday = true;

    emit(UserContinueInfoChooseDateState());
  }

  File? selectedImage;

  void setSelectedImage(File? image) {
    selectedImage = image!;
    print(selectedImage);
    emit(UserContinueInfoChooseImageState());
  }

  ///LoginScreen
  final TextEditingController loginEmailController =
      TextEditingController(text: "loay@loay.com");
  final TextEditingController loginPasswordController =
      TextEditingController(text: "password");
  LoginModel? loginModel;

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoadingState());
    await DioServices().post(
        url: ApiUrls.login,
        data: {'email': email, 'password': password}).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      CacheHelper.saveData(
          key: "barrierToken", value: loginModel!.data!.token.toString());
      emit(LoginSucssesState());
    }).catchError((error) {
      print(error);
      emit(LoginErrorState(error.toString()));
    });
  }
}
