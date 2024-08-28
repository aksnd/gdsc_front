import 'package:get/get.dart';
import 'package:myapp/app/modules/login/repository/login_repository.dart';

import '../data/repository/login_repository_impl.dart';

class RepositoryBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<LoginRepository>(LoginRepositoryImpl(),
        tag: (LoginRepository).toString(), permanent: true);
  }
}