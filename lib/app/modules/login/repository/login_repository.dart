import 'package:myapp/app/data/response/mountain_info_response.dart';

abstract class LoginRepository {
  Future<MountainInfoResponse> getMountainInfo();
}
