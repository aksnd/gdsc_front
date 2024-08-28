import 'package:myapp/app/data/mountain_metadata.dart';

class MountainInfoResponse {
  String type;
  String? errorMessage;
  MountainInfoResult? result;

  MountainInfoResponse(
      {required this.type, required this.errorMessage, required this.result});

  factory MountainInfoResponse.fromJson(Map<String, dynamic> json) {
    return MountainInfoResponse(
        type: json['type'],
        errorMessage: json['errorMessage'],
        result: MountainInfoResult.fromJson(json['result']));
  }
}

class MountainInfoResult {
  List<MountainMetadata> mountainMetadataList;

  MountainInfoResult({required this.mountainMetadataList});

  factory MountainInfoResult.fromJson(Map<String, dynamic> json) {
    return MountainInfoResult(
        mountainMetadataList: List<MountainMetadata>.from(
            json['result'].map((e) => MountainMetadata.fromJson(e))));
  }
}
