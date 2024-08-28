import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../data/mountain_metadata.dart';
import '../../../data/response/mountain_info_response.dart';
import '../../../routes/app_pages.dart';
import '../../login/repository/login_repository.dart';

class AddImageController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  final Rx<File?> _selectedImage = Rx<File?>(null);

  File? get selectedImage => _selectedImage.value;

  final String _serverUrl = "http://43.201.65.109:3000/api/dict/create";
  final int mountainId = Get.arguments['mountainId'];
  final String mountainName = Get.arguments['mountainName'];
  static const _storage = FlutterSecureStorage();

  final RxList<MountainMetadata> _rxMountainMetadataList = RxList.empty();

  List<MountainMetadata> get mountainMetadataList =>
      _rxMountainMetadataList.value;

  final LoginRepository _loginRepository =
      Get.find<LoginRepository>(tag: (LoginRepository).toString());

  // 이미지 선택 메서드
  Future<void> pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        _selectedImage.value = File(pickedFile.path);
      } else {
        if (kDebugMode) {
          print("No image selected.");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error picking image: $e");
      }
    }
  }

  // 이미지 업로드 메서드
  Future<void> uploadImage() async {
    if (_selectedImage.value == null) {
      if (kDebugMode) {
        print("No image selected to upload.");
      }
      return;
    }

    try {
      // 쿼리 파라미터를 URL에 포함
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            "$_serverUrl?userId=${await _storage.read(key: "id")}&mountainId=$mountainId"),
        // Uri.parse("$_serverUrl?userId=1000&mountainId=$mountainId"), //임시로 1000으로 해둠. 나중에 위에 코드로 변경 필요
      );

      // 이미지 파일 추가
      request.files.add(
        await http.MultipartFile.fromPath(
          'file', // 서버의 필드명
          _selectedImage.value!.path,
          filename: basename(_selectedImage.value!.path),
        ),
      );

      // 서버에 요청 전송
      var response = await request.send();

      // 응답 처리
      if (response.statusCode == 201) {
        if (kDebugMode) {
          print("Image uploaded successfully.");
        }
        await mountainInfoRequest();
        Get.offNamedUntil(Routes.MAIN, (route) => false,
            arguments: {"mountainMetadataList": mountainMetadataList});
      } else {
        if (kDebugMode) {
          print("Failed to upload image. Status code: ${response.statusCode}");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error uploading image: $e");
      }
    }
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

      await _handleMountainInfoRequestOnSuccess(response);
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
