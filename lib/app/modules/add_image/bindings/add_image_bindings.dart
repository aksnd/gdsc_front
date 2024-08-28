import 'package:get/get.dart';

import '../controllers/add_image_controller.dart';

class AddImageBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<AddImageController>(AddImageController());
  }
}
