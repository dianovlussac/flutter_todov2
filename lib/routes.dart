import 'package:flutter_todov2/screens/auth/login_screen.dart';
import 'package:flutter_todov2/screens/auth/signup_screen.dart';
import 'package:flutter_todov2/screens/home/home_screen.dart';
import 'package:get/get.dart';

class GetRoutes {
  static const String login = "/login";
  static const String signup = "/signup";
  static const String home = "/home";

  static List<GetPage> routes = [
    GetPage(
      name: GetRoutes.login,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: GetRoutes.signup,
      page: () => SignUpScreen(),
    ),
    GetPage(
      name: GetRoutes.home,
      page: () => HomeScreen(),
    ),
  ];
}
