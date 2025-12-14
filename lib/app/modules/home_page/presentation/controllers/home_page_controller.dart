import 'dart:convert';

import 'package:flutter_pioneer_assignment/app/core/constants/app_keys.dart';
import 'package:flutter_pioneer_assignment/app/core/data/models/repo_list_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageController extends GetxController {
  String sortedBy = "Default";

  void setSortedBy(String sBy) {
    sortedBy = sBy;

    if (repoListModel.items == null || repoListModel.items!.isEmpty) return;

    if (sortedBy == "Last update") {
      repoListModel.items!.sort((a, b) {
        final dateA = DateTime.tryParse(a.updatedAt ?? '') ?? DateTime(1970);
        final dateB = DateTime.tryParse(b.updatedAt ?? '') ?? DateTime(1970);
        return dateB.compareTo(dateA);
      });
    } else if (sortedBy == "Stars") {
      repoListModel.items!.sort(
        (a, b) => (b.stargazersCount ?? 0).compareTo(a.stargazersCount ?? 0),
      );
    }

    update();
  }

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
