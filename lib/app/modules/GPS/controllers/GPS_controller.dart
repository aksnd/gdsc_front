import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import '../../../routes/app_pages.dart';

class GPSController extends GetxController {
  // 위치 정보를 표시할 RxString 변수
  final RxString _locationMessage = "Press the button to get location".obs;

  String get locationMessage => _locationMessage.value;

  final String _serverUrl = "http://43.201.65.109:3000/api/gps/validate";

  // 위치를 가져오는 메서드
  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 위치 서비스 활성화 확인
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _locationMessage.value = "Location services are disabled.";
      return;
    }

    // 위치 권한 확인 및 요청
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        _locationMessage.value = "Location permissions are denied.";
        return;
      }
    }

    // 현재 위치 가져오기
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      // 위치 정보를 문자열로 포맷하여 업데이트
      if (kDebugMode) {
        print(position.latitude);
      }
      if (kDebugMode) {
        print(position.longitude);
      }
      await _sendLocationToServer(position.latitude, position.longitude);
    } catch (e) {
      _locationMessage.value = "Failed to get location: ${e.toString()}";
      debugPrint(e.toString());
    }
  }

  Future<void> _sendLocationToServer(double latitude, double longitude) async {
    try {
      final response = await http.post(
        Uri.parse("$_serverUrl?latitude=$latitude&longitude=$longitude"),
        headers: {
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 201) {
        if (response.body == '') {
          _locationMessage.value = "no mountain nearby";
        } else {
          final responseData = jsonDecode(response.body);
          final int id = responseData['id'];
          final String name = responseData['name'];
          Get.offAndToNamed(Routes.ADD_IMAGE_PAGE, arguments: {
            "mountainId": id,
            "mountainName": name,
          });
          //_locationMessage.value = "ID: $id, Name: $name";
        }
      } else {
        _locationMessage.value = "${response.statusCode}" "Failed to post location: ${response.reasonPhrase}";
      }
    } catch (e) {
      _locationMessage.value = "Error: ${e.toString()}";
      debugPrint(e.toString());
    }
  }
}
