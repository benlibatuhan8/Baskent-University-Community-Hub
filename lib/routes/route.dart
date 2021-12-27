import 'package:flutter/material.dart';
import 'package:comhub/screens/login.dart';
import 'package:comhub/screens/register.dart';
import 'package:comhub/screens/home.dart';
import 'package:comhub/screens/profile.dart';

class Routes {
  static const login = '/login';
  static const home = '/home';
  static const register = '/register';
  static const prodlist = '/prodlist';
  static const settings = '/settings';

  static MaterialPageRoute generateRoute(RouteSettings routeSettings,
      {Widget? root, String? routeName}) {
    return MaterialPageRoute(
      settings: routeSettings,
      builder: (context) => _buildPage(
          routeSettings.name, routeSettings.arguments, root, routeName),
    );
  }

  static Widget _buildPage(
      String? name, Object? arguments, Widget? newRoot, String? routeName) {
    if (routeName != null) {
      newRoot = _buildPage(routeName, arguments, null, null);
    }

    switch (name) {
      case login:
        return LoginScreen();

      case home:
        return HomeScreen();

      case register:
        return RegisterScreen();

      default:
        return LoginScreen(); // 404 page
    }
  }
}
