import 'package:flutter_pioneer_assignment/app/modules/repo_details_page/presentation/controllers/repo_details_page_controller.dart';
import 'package:get/get.dart';

class RepoDetailsPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RepoDetailsPageController(), fenix: true);
  }
}
