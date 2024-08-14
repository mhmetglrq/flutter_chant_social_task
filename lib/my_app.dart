import 'package:flutter/material.dart';

import 'config/routes/app_router.dart';
import 'config/routes/route_names.dart';
import 'config/themes/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme(context),
      home: const Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
      initialRoute: RouteNames.home,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
