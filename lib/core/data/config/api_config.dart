class ApiConfig {
  static const String baseUrl = 'http://0.0.0.0:8000/api/';

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
