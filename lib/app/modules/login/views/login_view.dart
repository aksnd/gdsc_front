import 'package:flutter/material.dart';
import 'package:myapp/app/cores/bases/base_view.dart';
import 'package:myapp/app/cores/values/app_colors.dart';
import 'package:myapp/app/modules/login/controllers/login_controller.dart';

class LoginView extends BaseView<LoginController> {
  LoginView({super.key});

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
            child: Image.asset("assets/images/logo.png"),
          ),
          const SizedBox(
            height: 195,
          ),
          Container(
            decoration: const BoxDecoration(
              color: AppColors.primaryPlaceholder,
            ),
            width: 206,
            height: 42,
            child: TextField(
              obscureText: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'ID',
              ),
              controller: controller.idController,
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          Container(
            decoration: const BoxDecoration(
              color: AppColors.primaryPlaceholder,
            ),
            width: 206,
            height: 42,
            child: TextField(
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'PW',
              ),
              controller: controller.pwController,
            ),
          ),
          const SizedBox(
            height: 36,
          ),
          ElevatedButton(
            onPressed: controller.onLoginPressed(),
            style: ElevatedButton.styleFrom(fixedSize: const Size(206, 42)),
            child: const Text(
              "login",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget? bottomNavigationBar(BuildContext context) {
    return null;
  }
}
