import 'package:get/get.dart';
import 'package:elzo_wear/controllers/splash_controller.dart';

class SplashBinding implements Bindings{

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<SplashController>(SplashController());
  }

}