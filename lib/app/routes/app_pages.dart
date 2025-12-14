import 'package:flutter_pioneer_assignment/app/core/data/models/repo_model.dart';
import 'package:flutter_pioneer_assignment/app/modules/repo_details_page/presentation/bindings/repo_details_page_binding.dart';
import 'package:flutter_pioneer_assignment/app/modules/repo_details_page/presentation/views/repo_details_page.dart';
import 'package:flutter_pioneer_assignment/app/modules/splash_page/presentation/bindings/splash_page_bindings.dart';
import 'package:flutter_pioneer_assignment/app/modules/splash_page/presentation/views/splash_page.dart';
import 'package:get/get.dart';
import '../modules/home_page/presentation/bindings/home_binding.dart';
import '../modules/home_page/presentation/views/home_page.dart';
import 'app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.homeRoute,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.splashRoute,
      page: () => SplashPage(),
      binding: SplashPageBindings(),
    ),
    GetPage(
      name: AppRoutes.repoDetailsRoute,
      page: () => RepoDetailsPage(repoModel: RepoModel.fromJson(Get.arguments)),
      binding: RepoDetailsPageBinding(),
    ),
  ];
}
