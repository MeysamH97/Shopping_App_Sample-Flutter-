import 'package:get/get.dart';
import 'package:elzo_wear/controllers/product_controller.dart';

class ProductBinding implements Bindings{

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<ProductController>(ProductController());
  }
}