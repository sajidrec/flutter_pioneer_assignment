import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pioneer_assignment/app/core/constants/app_colors.dart';
import 'package:flutter_pioneer_assignment/app/modules/home_page/presentation/controllers/home_page_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home page"), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              Text(
                "Repositories",
                style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: GetBuilder<HomePageController>(
                  builder: (controller) {
                    return ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) =>
                          _buildRepoCard(controller, index),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 8.h),
                      itemCount: controller.repoListModel.items?.length ?? 0,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InkWell _buildRepoCard(HomePageController controller, int index) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.black.withValues(alpha: .2)),
          borderRadius: BorderRadiusGeometry.circular(16.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(6.sp),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.green.withValues(alpha: .35),
                    width: 2.sp,
                  ),
                  borderRadius: BorderRadius.circular(999.r),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(999.r),
                  child: CachedNetworkImage(
                    width: 56.w,
                    height: 56.w,
                    fit: BoxFit.cover,
                    imageUrl:
                        controller
                            .repoListModel
                            .items?[index]
                            .owner
                            ?.avatarUrl ??
                        "",
                    errorWidget: (context, url, error) =>
                        Icon(Icons.broken_image, color: AppColors.green),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Repo : ${controller.repoListModel.items?[index].fullName ?? ""}",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "owner name : ${controller.repoListModel.items?[index].owner?.login ?? ""}",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black.withValues(alpha: .75),
                      ),
                    ),
                    Text(
                      "last updated: ${DateFormat('MM-dd-yyyy HH:mm').format(DateTime.parse(controller.repoListModel.items?[index].updatedAt ?? ""))}",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black.withValues(alpha: .75),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: AppColors.gold),
                        SizedBox(width: 4.w),
                        Text(
                          controller.repoListModel.items?[index].stargazersCount
                                  .toString() ??
                              "0",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
