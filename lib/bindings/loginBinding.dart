import 'package:dendy_app/controllers/dashboardController.dart';
import 'package:dendy_app/controllers/loginScreenController.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginScreenController>(() => LoginScreenController());
  }
}
