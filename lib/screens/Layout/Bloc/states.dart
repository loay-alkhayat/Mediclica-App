abstract class LayoutStates {
  const LayoutStates();
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
