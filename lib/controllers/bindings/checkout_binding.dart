import 'package:get/get.dart';
import 'package:elzo_wear/controllers/checkout_controller.dart';


class CheckoutBinding implements Bindings{

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<CheckoutController>(CheckoutController());
  }
}