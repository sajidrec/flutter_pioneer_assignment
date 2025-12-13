import 'package:flutter/material.dart';
import 'package:flutter_pioneer_assignment/app/core/constants/app_assets.dart';
import 'package:flutter_pioneer_assignment/app/modules/splash_page/presentation/controllers/splash_page_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset(AppAssets.pioneerLogo),
            ),
            Positioned(
              bottom: 20,
              left: 10,
              right: 10,
              child: Column(
                children: [
                  GetBuilder<SplashPageController>(
                    builder: (controller) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Spacer(),
                              Text(
                                "Loading",
                                style: TextStyle(fontSize: 30.sp),
                              ),
                              Expanded(
                                child: Text(
                                  "." * controller.loaderDots,
                                  style: TextStyle(
                                    fontSize: 35.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
