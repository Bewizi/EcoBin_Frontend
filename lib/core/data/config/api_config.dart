class ApiConfig {
  static const String baseUrl = 'https://b42c2d06b978.ngrok-free.app/api/';

  static void printBaseUrl() => print("Base URL IS: $baseUrl");

  static const String loginEndpoint = 'login';
  static const String registerEndpoint = 'register';
  static const String logoutEndpoint = 'logout';

  static Map<String, String> get headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  static Map<String, String> authHeaders(String token) => {
    ...headers,
    'Authorization': 'Bearer $token',
  };
}
