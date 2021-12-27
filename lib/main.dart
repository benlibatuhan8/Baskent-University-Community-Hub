import 'package:comhub/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:comhub/routes/route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(child: Consumer(builder: (context, ref, child) {
      final isUserLoggedIn = false;

      return MaterialApp(
        title: 'Community Hub',
        theme: ThemeData(primarySwatch: Colors.indigo),
        initialRoute: isUserLoggedIn ? Routes.home : Routes.login,
        home: LoginScreen(),
        onGenerateRoute: (routeSettings) => Routes.generateRoute(routeSettings,
            routeName: isUserLoggedIn ? Routes.home : Routes.login),
      );
    }));
  }
}
