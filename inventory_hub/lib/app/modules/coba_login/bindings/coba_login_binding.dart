import 'package:get/get.dart';

import '../controllers/coba_login_controller.dart';

class CobaLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CobaLoginController>(
      () => CobaLoginController(),
    );
  }
}
