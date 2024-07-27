import 'package:equatable/equatable.dart';

abstract class LayoutStates extends Equatable {
  const LayoutStates();

  @override
  List<Object> get props {
    return [];
  }
}

class LayoutInitialState extends LayoutStates {}

///CategoriesState
class LayoutGetCategoriesLoadingState extends LayoutStates {}

class LayoutGetCategoriesSucsessState extends LayoutStates {}

class LayoutGetCategoriesErrorState extends LayoutStates {}

///ProfileState

class LayoutGetProfileLoadingState extends LayoutStates {}

class LayoutGetProfileSucsessState extends LayoutStates {}

class LayoutGetProfileErrorState extends LayoutStates {}

///DoctorsState

class LayoutGetDoctorsLoadingState extends LayoutStates {}

class LayoutGetDoctorsSucsessState extends LayoutStates {}

class LayoutGetDoctorsErrorState extends LayoutStates {}

class GetDoctorsPagerAddState extends LayoutStates {}

///DoctorDetaielsState

class GetDoctorDetaielsLoadingState extends LayoutStates {}

class GetDoctorDetaielsSucsessState extends LayoutStates {}

class GetDoctorDetaielsErrorState extends LayoutStates {}

///DoctorServicesState

class GetDoctorServicesLoadingState extends LayoutStates {}

class GetDoctorServicesSucsessState extends LayoutStates {}

class GetDoctorServicesErrorState extends LayoutStates {}

///DoctorDatesState

class GetDoctorDatesLoadingState extends LayoutStates {}

class GetDoctorDatesSucsessState extends LayoutStates {}

class GetDoctorDatesErrorState extends LayoutStates {}

///DoctorWorkHoursState

class GetDoctorWorkHoursLoadingState extends LayoutStates {}

class GetDoctorWorkHoursSucsessState extends LayoutStates {}

class GetDoctorWorkHoursErrorState extends LayoutStates {}

///BuutonsBookState

class ChangeServiceState extends LayoutStates {}

class ChangeServicefalseState extends LayoutStates {}

class ChangedateState extends LayoutStates {}

class ChangedatefalseState extends LayoutStates {}

class ChangetimeState extends LayoutStates {}

class ChangetppedState extends LayoutStates {}

class ChangefalsetppedState extends LayoutStates {}

class ChangetimefalseState extends LayoutStates {}

///DoctorAppointmentState

class MakeAppointmentLoadingState extends LayoutStates {}

class MakeAppointmentSucsessState extends LayoutStates {}

class MakeAppointmentErrorState extends LayoutStates {}

///AppointmentState

class GetAppointmentsLoadingState extends LayoutStates {}

class GetAppointmentsSucsessState extends LayoutStates {}

class GetAppointmentsErrorState extends LayoutStates {}

///CentersState

class ResetDoctorSelectionState extends LayoutStates {}

class GetCentersLoadingState extends LayoutStates {}

class GetCentersSucsessState extends LayoutStates {}

class GetCentersErrorState extends LayoutStates {}

///CenterDetaielsState

class GetCenterDetaielsLoadingState extends LayoutStates {}

class GetCenterDetaielsSucsessState extends LayoutStates {}

class GetCenterDetaielsErrorState extends LayoutStates {}

///CenterDoctorsState

class GetCenterDoctorLoadingState extends LayoutStates {}

class GetCenterDoctorSucsessState extends LayoutStates {}

class GetCenterDoctorErrorState extends LayoutStates {}

class ChangeExpandedState extends LayoutStates {}

///SearchDoctorsState

class SearchDoctorLoadingState extends LayoutStates {}

class SearchDoctorSucsessState extends LayoutStates {}

class SearchDoctorErrorState extends LayoutStates {}

///AIState

class GetAiLoadingState extends LayoutStates {}

class GetAiSucsessState extends LayoutStates {}

class GetAiErrorState extends LayoutStates {}

///CancellBookStates
class CancelbookLoadingState extends LayoutStates {}

class CancelbookSucssesState extends LayoutStates {}

class CancelbookErrorState extends LayoutStates {}
