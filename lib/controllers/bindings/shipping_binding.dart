import 'package:get/get.dart';
import 'package:elzo_wear/controllers/checkout_controller.dart';

class ShippingBinding implements Bindings{

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put <CheckoutController> (CheckoutController());
  }

}