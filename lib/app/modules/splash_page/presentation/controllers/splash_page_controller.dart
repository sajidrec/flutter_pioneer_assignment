import 'dart:async';
import 'dart:convert';

import 'package:flutter_pioneer_assignment/app/core/constants/app_colors.dart';
import 'package:flutter_pioneer_assignment/app/core/constants/app_keys.dart';
import 'package:flutter_pioneer_assignment/app/core/errors/app_exceptions.dart';
import 'package:flutter_pioneer_assignment/app/core/network/api_endpoints.dart';
import 'package:flutter_pioneer_assignment/app/core/network/dio_client.dart';
import 'package:flutter_pioneer_assignment/app/modules/splash_page/data/models/repo_list_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPageController extends GetxController {
  int loaderDots = 1;

  Future<void> startDotLoading() async {
    Timer.periodic(Duration(milliseconds: 500), (timer) {
      loaderDots++;
      loaderDots = loaderDots % 7;
      loaderDots == 0 ? loaderDots = 1 : loaderDots;
      update();
    });
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
    } on AppException catch (e) {
      Get.snackbar(
        "Error occured",
        e.message,
        backgroundColor: AppColors.red,
        colorText: AppColors.white,
      );
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
