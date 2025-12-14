import 'dart:async';
import 'dart:convert';

import 'package:flutter_pioneer_assignment/app/core/constants/app_colors.dart';
import 'package:flutter_pioneer_assignment/app/core/constants/app_keys.dart';
import 'package:flutter_pioneer_assignment/app/core/errors/app_exceptions.dart';
import 'package:flutter_pioneer_assignment/app/core/network/api_endpoints.dart';
import 'package:flutter_pioneer_assignment/app/core/network/dio_client.dart';
import 'package:flutter_pioneer_assignment/app/modules/splash_page/data/models/repo_list_model.dart';
import 'package:flutter_pioneer_assignment/app/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPageController extends GetxController {
  int loaderDots = 1;
  int waitingSteps = 0;

  Future<void> startDotLoading() async {
    Timer.periodic(Duration(milliseconds: 500), (timer) {
      waitingSteps++;
      loaderDots++;
      loaderDots = loaderDots % 7;
      loaderDots == 0 ? loaderDots = 1 : loaderDots;
      update();
    });
  }

  Future<void> _moveToNextPage() async {
    if (waitingSteps < 5) {
      await Future.delayed(Duration(seconds: 2));
    }
    Get.offAllNamed(AppRoutes.homeRoute);
  }

  Future<void> _fetchDataFromInternet() async {
    try {
      DioClient dioClient = DioClient();

      RepoListModel repoListModel = RepoListModel.fromJson(
        await dioClient.get(ApiEndpoints.fetchRepositoryUrl),
      );

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      await sharedPreferences.setString(
        AppKeys.dataStoreKey,
        jsonEncode(repoListModel.toJson()),
      );

      // print("sajid testing ${repoListModel.items}");

      _moveToNextPage();
    } on AppException catch (e) {
      Get.snackbar(
        "Error occured",
        e.message,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      String data = sharedPreferences.getString(AppKeys.dataStoreKey) ?? "";

      if (data.isEmpty) {
        Get.snackbar(
          "Something went wrong",
          "Most probably network error",
          backgroundColor: AppColors.red,
          colorText: AppColors.white,
        );
      } else {
        Get.snackbar(
          "We will show old fetched data",
          "",
          backgroundColor: AppColors.green,
          colorText: AppColors.white,
        );

        _moveToNextPage();
      }
    } catch (e) {
      Get.snackbar(
        "Error occured",
        e.toString(),
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
    }
  }

  @override
  void onInit() async {
    super.onInit();
    await startDotLoading();
    await _fetchDataFromInternet();
  }
}
