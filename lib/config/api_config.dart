class ApiConfig {
  // backend URL
  static const String baseUrl =
      'https://911f-119-13-157-213.ngrok-free.app/todo-api';

  // API endpoints
  static const String login = '$baseUrl/login.php';
  static const String register = '$baseUrl/register.php';
  static const String tasks = '$baseUrl/index.php';
}
