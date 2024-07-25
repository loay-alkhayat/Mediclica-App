class ApiUrls {
  static const String baseUrl = 'https://medical.alhasanshnnar.com/api';
  // static const String baseUrl = 'http://192.168.249.28:8000/api';

  // TODO : ADD YOUR APIS ENDPOINTS HERE
  static const String register = '$baseUrl/register';
  static const String login = '$baseUrl/login';
  static const String categories = '$baseUrl/categories';
  static const String profile = '$baseUrl/profile';
  static const String doctors = '$baseUrl/doctor';
  static const String doctorDetaiels = '$baseUrl/doctorid';
  static const String doctorServices = '$baseUrl/client/service';
  static const String doctorDates = '$baseUrl/client/work/dates';
  static const String doctorWorkHour = '$baseUrl/client/available';
  static const String appointment = '$baseUrl/client/add/book';
  static const String userAppointment = '$baseUrl/bookings/status';
  static const String centers = '$baseUrl/centers';
  static const String centerDetail = '$baseUrl/center';
  static const String searchDoctors = '$baseUrl/client/doctors/search';
  static const String ai = '$baseUrl/client/ai';
  static const String logOut = '$baseUrl/logout';
  static const String cancelBook = '$baseUrl/client/update/booking/status';
}
