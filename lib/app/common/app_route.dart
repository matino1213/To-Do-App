import 'package:get/get.dart';
import 'package:to_do/app/pages/home/view.dart';
import 'package:to_do/app/pages/note_editor/view.dart';
import 'package:to_do/app/pages/note_manager/view.dart';
import 'package:to_do/app/pages/splash/view.dart';
import 'package:to_do/app/pages/task_manager/view.dart';

class AppRoute {
  static const HOME = "/Home";
  static const SPLASH = "/Splash";
  static const TASKMANAGER = "/TaskManager";
  static const NOTEMANAGER = "/NoteManager";
  static const NOTEEDITOR = "/NoteEditor";
  static List<GetPage> routes = [
    GetPage(
      name: AppRoute.HOME,
      page: () => const HomePage(),
    ),
    GetPage(
      name: AppRoute.TASKMANAGER,
      page: () => TaskManagerPage(),
    ),
    GetPage(
      name: AppRoute.NOTEMANAGER,
      page: () => const NoteManagerPage(),
    ),
    GetPage(
      name: AppRoute.NOTEEDITOR,
      page: () => const NoteEditorPage(),
    ),
    GetPage(
      name: AppRoute.SPLASH,
      page: () => const SplashPage(),
    ),
  ];
}
