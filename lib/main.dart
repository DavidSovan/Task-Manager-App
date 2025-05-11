import 'package:flutter/material.dart';
import 'package:task_manager/screens/auth/login_screen.dart';
import 'package:task_manager/screens/spash_screen.dart';
import 'package:task_manager/screens/tasks/task_screen.dart';
import 'package:task_manager/services/auth_service.dart';
import 'package:task_manager/config/api_config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      theme: ThemeData(
        snackBarTheme: SnackBarThemeData(
          backgroundColor: Colors.green[100],
          contentTextStyle: TextStyle(color: Colors.black),
          actionTextColor: Colors.yellow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        colorScheme: ColorScheme.light().copyWith(
          primary: Color(0xFF97BC62),
          secondary: Color(0xFF2C5F2D),
        ),
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Roboto',
      ),
      home: SplashScreen(),
    );
  }
}

class AuthCheck extends StatefulWidget {
  const AuthCheck({Key? key}) : super(key: key);

  @override
  _AuthCheckState createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  final AuthService _authService = AuthService(baseUrl: ApiConfig.baseUrl);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _authService.isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final bool isLoggedIn = snapshot.data ?? false;
        return isLoggedIn ? const TaskScreen() : const LoginScreen();
      },
    );
  }
}
