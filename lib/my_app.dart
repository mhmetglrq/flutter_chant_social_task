import 'package:flutter/material.dart';

import 'config/routes/app_router.dart';
import 'config/routes/route_names.dart';
import 'config/themes/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.darkTheme(context),
      initialRoute: RouteNames.onboarding,
      onGenerateRoute: AppRouter.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
