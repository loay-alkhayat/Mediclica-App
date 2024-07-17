abstract class AuthStates {
  const AuthStates();
}

class AuthInitialState extends AuthStates {}

///RegisterStates

class RegisterLoadingState extends AuthStates {}

class RegisterSucssesState extends AuthStates {}

class RegisterErrorState extends AuthStates {}

///LoginStates

class LoginLoadingState extends AuthStates {}

class LoginSucssesState extends AuthStates {}

class LoginErrorState extends AuthStates {
  final String error;

  LoginErrorState(this.error);
}

///ContinueInformationStates
class UserContinueInfoCheckGenderState extends AuthStates {}

class UserContinueInfoCheckGender2State extends AuthStates {}

class UserContinueInfoChooseDateState extends AuthStates {}

class UserContinueInfoChooseImageState extends AuthStates {}
