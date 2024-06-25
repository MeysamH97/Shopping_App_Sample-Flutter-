import 'package:get/get.dart';
import 'package:elzo_wear/controllers/cart_controller.dart';

class CartBinding implements Bindings{

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put <CartController> (CartController());
  }

}