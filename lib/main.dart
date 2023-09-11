import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:otomobil/views/passwordchange/password_change.dart';
import 'package:otomobil/views/register/register_page.dart';
import 'firebase_options.dart';
import 'views/home/home_Page.dart';
import 'views/login/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/LoginPage": (context) => LoginPage(),
        "/RegisterPage": (context) => RegisterPage(),
        "/homePage": (context) => HomePage(),
        "/passwordchangePage": (context) => PasswordchangePage(),
      },
      theme: ThemeData(),
      home: const LoginPage(),
    );
  }
}
