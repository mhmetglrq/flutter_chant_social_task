import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chant_social_task/firebase_options.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'my_app.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('userSettings');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
