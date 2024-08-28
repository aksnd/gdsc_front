import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:myapp/app/data/response/mountain_info_response.dart';
import 'package:myapp/app/data/source/login_data_source.dart';
import 'package:http/http.dart' as http;

class LoginDummy implements LoginDataSource {
  static final _storage = FlutterSecureStorage();

  @override
  Future<MountainInfoResponse> getMountainInfo() async {
    Map<String, dynamic> result = await asyncMountainList();

    return Future(() => MountainInfoResponse(
          type: "SUCCESS",
          errorMessage: null,
          result: MountainInfoResult.fromJson(result),
        ));
  }

  Future<Map<String, dynamic>> asyncMountainList() async {
    final url = Uri.parse(
        'http://43.201.65.109:3000/api/dict?id=${await _storage.read(key: "id")}');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        print(json.decode(response.body));
        return (json.decode(response.body)); // JSON 응답을 Map으로 디코딩
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to load data');
    }
  }

  String dummy = """{
      "type": "success",
  "errorMessage": "",
  "result": [
  {
  "name": "Mount Everest",
  "level": 5,
  "conquerDate": "2024-08-24T10:30:00.000Z",
  "conquered": 1
  },
  {
  "name": "K2",
  "level": 5,
  "conquerDate": null,
  "conquered": 0
  },
  {
  "name": "Mount Kilimanjaro",
  "level": 4,
  "conquerDate": null,
  "conquered": 0
  },
  {
  "name": "Denali",
  "level": 5,
  "conquerDate": null,
  "conquered": 0
  },
  {
  "name": "Mount Fuji",
  "level": 3,
  "conquerDate": null,
  "conquered": 0
  },
  {
  "name": "Mont Blanc",
  "level": 4,
  "conquerDate": null,
  "conquered": 0
  }
  ]
}""";
}
