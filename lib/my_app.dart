import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'config/routes/app_router.dart';
import 'config/routes/route_names.dart';
import 'config/themes/app_theme.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Box userSettings = Hive.box('userSettings');
  @override
  Widget build(BuildContext context) {
    log("userSettings: ${userSettings.get("name")}");
    return MaterialApp(
      theme: AppTheme.darkTheme(context),
      initialRoute:
          (userSettings.get("name") != null && userSettings.get("name") != "")
              ? RouteNames.bottomNavBar
              : RouteNames.onboarding,
      onGenerateRoute: AppRouter.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
