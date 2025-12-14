import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pioneer_assignment/app/core/constants/app_colors.dart';
import 'package:flutter_pioneer_assignment/app/core/data/models/repo_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class RepoDetailsPage extends StatelessWidget {
  const RepoDetailsPage({super.key, required this.repoModel});

  final RepoModel repoModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(repoModel.name ?? ""), centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.sp),
            child: Column(
              children: [
                SizedBox(height: 24.h),
                _buildProfilePicture(),
                SizedBox(height: 8.h),
                Text(
                  repoModel.fullName ?? "",
                  style: TextStyle(fontSize: 16.sp),
                ),
                SizedBox(height: 8.h),
                Text(
                  repoModel.owner?.login ?? "",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.black.withValues(alpha: .85),
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Spacer(),
                    Icon(Icons.star, color: AppColors.gold),
                    Text(
                      repoModel.stargazersCount.toString(),
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.black.withValues(alpha: .85),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  "Last updated at ${DateFormat('MM-dd-yyyy HH:mm').format(DateTime.parse(repoModel.updatedAt ?? ""))}",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.black.withValues(alpha: .85),
                  ),
                ),
                SizedBox(height: 8.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Description",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(repoModel.description ?? ""),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Center _buildProfilePicture() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999.r),
          border: Border.all(color: AppColors.green, width: 2.sp),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(999.r),
          child: CachedNetworkImage(
            imageUrl: repoModel.owner?.avatarUrl ?? "",
            width: 100.w,
            height: 100.w,
          ),
        ),
      ),
    );
  }
}
