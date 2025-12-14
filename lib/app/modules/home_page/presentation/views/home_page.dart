import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pioneer_assignment/app/core/constants/app_colors.dart';
import 'package:flutter_pioneer_assignment/app/modules/home_page/presentation/controllers/home_page_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
                      itemBuilder: (context, index) => Row(
                        children: [
                          CachedNetworkImage(
                            width: 50.w,
                            height: 50.h,
                            imageUrl:
                                controller
                                    .repoListModel
                                    .items?[index]
                                    .owner
                                    ?.avatarUrl ??
                                "",
                            errorWidget: (context, url, error) => Icon(
                              Icons.broken_image,
                              color: AppColors.green,
                            ),
                          ),
                        ],
                      ),
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
}
