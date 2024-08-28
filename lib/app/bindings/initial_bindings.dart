import 'package:get/get.dart';

import 'local_source_bindings.dart';
import 'repository_bindings.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    LocalSourceBindings().dependencies();
    RepositoryBindings().dependencies();
  }
}
