import 'package:get/get.dart';

import '../data/local/dummy/login_dummy.dart';
import '../data/source/login_data_source.dart';

class LocalSourceBindings implements Bindings{
  @override
  void dependencies() {
    Get.put<LoginDataSource>(
      LoginDummy(),
      tag: (LoginDataSource).toString(),
      permanent: true,
    );
  }

}