import 'package:comhub/screens/admin_page.dart';
import 'package:comhub/screens/calendar.dart';
import 'package:comhub/screens/comlistpage.dart';
import 'package:comhub/screens/compage.dart';
import 'package:comhub/screens/denememodpage.dart';
import 'package:comhub/screens/modPageAnn.dart';
import 'package:comhub/screens/modPageEvent.dart';
import 'package:comhub/screens/mycomlistpage.dart';
import 'package:comhub/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:comhub/screens/login/view/login.dart';
import 'package:comhub/screens/register/view/register.dart';
import 'package:comhub/screens/home.dart';
import 'package:comhub/screens/profile.dart';

class Routes {
  static const login = '/login';
  static const home = '/home';
  static const register = '/register';
  static const settings = '/settings';
  static const profile = '/profile';
  static const compage = '/compage';
  static const modpage1 = 'denememodpage';
  static const modpage2 = '/modpage2';
  static const modpage3 = '/modpage3';
  static const mycompage = '/mycompage';
  static const allcompage = '/allcompage';
  static const computersocietypage = '/computersocietypage';
  static const calendarscreen = '/calendarscreen';
  static const adminpagescreen = ' /adminpagescreen';

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
        return denememodpageScreen();

      case modpage2:
        return ModPageEventScreen();

      case modpage3:
        return ModPageAnnouncementScreen();

      case mycompage:
        return MyComListPageScreen();

      case allcompage:
        return ComListPageScreen();

      case computersocietypage:
        return ComPageScreen();

      case calendarscreen:
        return CalendarScreen();

      case adminpagescreen:
        return adminpageScreen();

      default:
        return LoginScreen(); // 404 page
    }
  }
}
