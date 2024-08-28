import 'package:flutter/material.dart';
import 'package:myapp/app/cores/values/app_colors.dart';

class MyAppbar {
  static PreferredSizeWidget main({
    required String nickname,
  }) {
    return AppBar(
        centerTitle: false,
        toolbarHeight: 45,
        backgroundColor: AppColors.appbarColor,
        titleSpacing: 20,
        automaticallyImplyLeading: false,
        title: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                  text: nickname,
                  style: const TextStyle(
                    fontSize: 17,
                    color: AppColors.nameColor,
                  )),
              const TextSpan(
                  text: '님, 오늘도 등산하러 가볼까요?',
                  style:
                      TextStyle(fontSize: 17, color: AppColors.primaryWhite)),
            ],
          ),
        ));
  }
}
