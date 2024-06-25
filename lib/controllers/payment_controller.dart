import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:elzo_wear/models/order_model.dart';

class PaymentController extends GetxController {

  Order order = Get.arguments;

  TextEditingController cardNumber1 = TextEditingController();
  TextEditingController cardNumber2 = TextEditingController();
  TextEditingController cardNumber3 = TextEditingController();
  TextEditingController cardNumber4 = TextEditingController();
  TextEditingController expireYear = TextEditingController();
  TextEditingController expireMonth = TextEditingController();
  TextEditingController cvv2 = TextEditingController();
  TextEditingController pass = TextEditingController();
}
