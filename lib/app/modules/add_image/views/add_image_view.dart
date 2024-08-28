import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/cores/bases/base_view.dart';
import '../controllers/add_image_controller.dart';

class AddImageView extends BaseView<AddImageController> {
  AddImageView({super.key});

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  @override
  Widget body(BuildContext context) {
    final AddImageController controller = Get.find<AddImageController>();

    // Arguments로 전달된 mountainId와 mountainName을 받음
    final String mountainName = Get.arguments['mountainName'];

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Obx(() {
            return controller.selectedImage == null
                ? const SizedBox(
                    height: 300,
                    width: 300,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.black,
                      ),
                    ),
                  )
                : Image.file(
                    controller.selectedImage!,
                    width: 300,
                    height: 300,
                  );
          }),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: controller.pickImage,
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(200, 42),
            ),
            child: const Text(
              "Capture Image",
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Kelly님 $mountainName의 멋진 정상을 보여주세요!",
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              controller.uploadImage();
            },
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(200, 42),
            ),
            child: const Text(
              "Upload Image",
              style: TextStyle(color: Colors.black, fontSize: 18),
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
