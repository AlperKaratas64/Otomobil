import 'package:get/get.dart';
import 'package:otomobil/views/home/home_page.dart';
import 'package:otomobil/views//profile/profile_page.dart';
import 'package:otomobil/views/register/register_page.dart';
import 'package:otomobil/views/login/login_page.dart';

List<GetPage> getPages = [
  GetPage(name: LoginPage.routeName, page: () => const LoginPage()),
  GetPage(name: RegisterPage.routeName, page: () => const RegisterPage()),
  GetPage(name: HomePage.routeName, page: () => const HomePage()),
  GetPage(name: ProfilePage.routeName, page: () => const ProfilePage()),
];
