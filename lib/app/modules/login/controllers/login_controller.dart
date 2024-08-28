import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:myapp/app/data/mountain_metadata.dart';
import 'package:myapp/app/data/response/mountain_info_response.dart';

import '../../../routes/app_pages.dart';
import '../repository/login_repository.dart';

class LoginController extends GetxController {
  final LoginRepository _loginRepository =
      Get.find<LoginRepository>(tag: (LoginRepository).toString());

  static const _storage = FlutterSecureStorage();

  final TextEditingController _idController = TextEditingController();

  TextEditingController get idController => _idController;
  final TextEditingController _pwController = TextEditingController();

  TextEditingController get pwController => _pwController;

  final RxList<MountainMetadata> _rxMountainMetadataList = RxList.empty();

  List<MountainMetadata> get mountainMetadataList =>
      _rxMountainMetadataList.value;

  VoidCallback onLoginPressed() {
    return () async {
      await _storage.write(key: "id", value: idController.text);
      await mountainInfoRequest();
      Get.toNamed(Routes.MAIN,
          arguments: {"mountainMetadataList": mountainMetadataList});
    };
  }

  Future<void> mountainInfoRequest() async {
    try {
      var request = _loginRepository.getMountainInfo();
      MountainInfoResponse response = await request;

      if (response.type != "SUCCESS") {
        throw Exception("type is not success");
      }

      if (response.result == null) {
        throw Exception("result is null");
      }

      _handleMountainInfoRequestOnSuccess(response);
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  _handleMountainInfoRequestOnSuccess(MountainInfoResponse response) {
    try {
      _rxMountainMetadataList(response.result?.mountainMetadataList);
      if (kDebugMode) {
        print("${mountainMetadataList.length}");
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
