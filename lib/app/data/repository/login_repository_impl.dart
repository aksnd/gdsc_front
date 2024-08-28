import 'package:get/get.dart';
import 'package:myapp/app/data/response/mountain_info_response.dart';
import 'package:myapp/app/data/source/login_data_source.dart';
import 'package:myapp/app/modules/login/repository/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final _source = Get.find<LoginDataSource>(tag: (LoginDataSource).toString());

  @override
  Future<MountainInfoResponse> getMountainInfo() {
    return _source.getMountainInfo();
  }
}
