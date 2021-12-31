import 'package:comhub/screens/compage.dart';
import 'package:comhub/screens/modPage.dart';
import 'package:comhub/screens/modPageAnn.dart';
import 'package:comhub/screens/modPageEvent.dart';
import 'package:comhub/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:comhub/screens/login.dart';
import 'package:comhub/screens/register.dart';
import 'package:comhub/screens/home.dart';
import 'package:comhub/screens/profile.dart';

class Routes {
  static const login = '/login';
  static const home = '/home';
  static const register = '/register';
  static const settings = '/settings';
  static const profile = '/profile';
  static const compage = '/compage';
  static const modpage1 = '/modpage1';
  static const modpage2 = '/modpage2';
  static const modpage3 = '/modpage3';

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

      case profile:
        return ProfileScreen();

      case settings:
        return SettingsScreen();

      case compage:
        return ComPageScreen();

      case modpage1:
        return ModPageScreen();

      case modpage2:
        return ModPageEventScreen();

      case modpage3:
        return ModPageAnnScreen();

      default:
        return LoginScreen(); // 404 page
    }
  }
}
