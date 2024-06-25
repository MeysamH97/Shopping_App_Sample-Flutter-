import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elzo_wear/models/product_model.dart';

class CategoryController extends GetxController {
  String categoryTitle = Get.parameters['title'] ?? '';
  List<Product> categoryProducts = Get.arguments;
  TextEditingController categoryScreenSearchController =
      TextEditingController();
}
