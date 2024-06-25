import 'package:get/get.dart';
import 'package:elzo_wear/controllers/category_controller.dart';

class CategoryBinding implements Bindings{

  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<CategoryController>(CategoryController());
  }

}