import 'package:get/get.dart';
import 'package:myapp/app/modules/GPS/controllers/GPS_controller.dart';

class GPSBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<GPSController>(GPSController());
  }
}
