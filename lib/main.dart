import 'package:auth_app/pages/home_page.dart';
import 'package:auth_app/pages/login_page.dart';
import 'package:auth_app/pages/register_page.dart';
import 'package:auth_app/services/shared_service.dart';
import 'package:flutter/material.dart';

Widget _defaultHome = const LoginPage();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool _result = await SharedService.isLoggedIn();
  if (_result) {
    _defaultHome = HomePage();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => _defaultHome,
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/register': (context) => const RegisterPage(),
      },
    );
  }
}
