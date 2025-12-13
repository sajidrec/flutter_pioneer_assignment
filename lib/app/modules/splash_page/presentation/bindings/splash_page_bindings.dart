import 'package:flutter_pioneer_assignment/app/modules/splash_page/presentation/controllers/splash_page_controller.dart';
import 'package:get/get.dart';

class SplashPageBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashPageController(), fenix: true);
  }
}
