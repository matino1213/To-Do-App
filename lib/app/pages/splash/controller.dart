import 'package:get/get.dart';
import 'package:to_do/app/common/app_route.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Future.delayed(const Duration(milliseconds: 100), () {
      Get.offAllNamed(AppRoute.HOME);
    });
  }
}
