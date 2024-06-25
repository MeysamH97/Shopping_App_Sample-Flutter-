import 'package:get/get.dart';
import 'package:elzo_wear/controllers/user_controller.dart';

class UserBinding implements Bindings{

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<UserController>(UserController());
  }

}