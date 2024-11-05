import 'package:get/get.dart';
import 'package:to_do/app/pages/home/controller.dart';
import 'package:to_do/app/pages/note_editor/controller.dart';
import 'package:to_do/app/pages/note_manager/controller.dart';
import 'package:to_do/app/pages/splash/controller.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController());
    Get.put<SplashController>(SplashController());
    Get.put<NoteManagerController>(NoteManagerController());
    Get.lazyPut<NoteEditorController>(
      () => NoteEditorController(),
      fenix: true,
    );
  }
}
