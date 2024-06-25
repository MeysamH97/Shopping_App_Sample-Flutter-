import 'package:get/get.dart';
import 'package:elzo_wear/controllers/payment_controller.dart';

class PaymentBinding implements Bindings{

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put <PaymentController> (PaymentController());
  }

}