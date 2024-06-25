import 'package:get/get.dart';
import 'package:elzo_wear/controllers/order_controller.dart';

class OrderBinding implements Bindings{

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put <OrderController> (OrderController());
  }

}