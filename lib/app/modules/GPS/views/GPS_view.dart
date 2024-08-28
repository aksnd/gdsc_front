import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/cores/bases/base_view.dart'; // BaseView의 경로
import 'package:myapp/app/cores/values/app_colors.dart'; // AppColors의 경로
import '../controllers/GPS_controller.dart';

class GPSView extends BaseView<GPSController> {
  GPSView({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  @override
  Widget body(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: AppColors.transparency,
            ),
            width: 206,
            height: 247,
            child: Image.asset("assets/images/logo.png"), // 로고 이미지
          ),
          const SizedBox(height: 36),
          SizedBox(
            width: 206,
            height: 42,
            child: ElevatedButton(
              onPressed: controller.getCurrentLocation, // 버튼 클릭 시 위치 정보 가져오기
              style: ElevatedButton.styleFrom(fixedSize: const Size(206, 42)),
              child: const Text(
                "Get Location",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Obx(() => Container(
                decoration: const BoxDecoration(
                  color: AppColors.primaryPlaceholder,
                ),
                width: 206,
                height: 42,
                child: Center(
                  child: Text(
                    controller.locationMessage, // 위치 정보 표시
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              )),
        ],
      ),
    );
  }

  @override
  Widget? bottomNavigationBar(BuildContext context) {
    return null;
  }
}
