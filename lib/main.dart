import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do/app/common/app_binding.dart';
import 'package:to_do/app/common/app_route.dart';
import 'package:to_do/models/note.dart';
import 'package:to_do/models/task.dart';

import 'app/pages/home/view.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(NoteAdapter());
  await Hive.openBox('tasks');
  await Hive.openBox('notes');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: AppBinding(),
      getPages: AppRoute.routes,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Lufga',
      ),
      initialRoute: AppRoute.SPLASH,
    );
  }
}
