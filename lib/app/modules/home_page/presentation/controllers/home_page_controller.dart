import 'dart:convert';

import 'package:flutter_pioneer_assignment/app/core/constants/app_keys.dart';
import 'package:flutter_pioneer_assignment/app/core/data/models/repo_list_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageController extends GetxController {
  RepoListModel repoListModel = RepoListModel();

  @override
  Future<void> onInit() async {
    super.onInit();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    repoListModel = RepoListModel.fromJson(
      jsonDecode(sharedPreferences.getString(AppKeys.dataStoreKey) ?? ""),
    );

    update();
  }
}
