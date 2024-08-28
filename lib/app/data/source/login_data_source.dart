import 'package:myapp/app/data/response/mountain_info_response.dart';

abstract class LoginDataSource {
  Future<MountainInfoResponse> getMountainInfo();
}
