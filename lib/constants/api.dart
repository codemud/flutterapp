class ApiConstants {
  static const String BASE_URL = 'https://www.codeboy.com/zhsqapi/';

  // Endpoints
  static const String LOGIN = BASE_URL + 'user/login';
  static const String REGISTER = BASE_URL + 'user/register';
  static const String FETCH_USER = '/user';
  static const String UPDATE_PROFILE = '/user/update';
  static const String LOGOUT = '/logout';

  // Error Messages
  static const String ERROR_NETWORK = 'Network error, please try again later.';
  static const String ERROR_UNAUTHORIZED =
      'Unauthorized access, please login again.';
}
