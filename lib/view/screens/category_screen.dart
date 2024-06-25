import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elzo_wear/controllers/category_controller.dart';
import 'package:elzo_wear/view/widgets/base_widget.dart';
import 'package:elzo_wear/view/widgets/list_products.dart';

class CategoryScreen extends GetView<CategoryController> {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              controller.categoryTitle,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const Spacer(),
            const Icon(Iconsax.search_normal),
          ],
        ),
      ),
      body: BaseWidget(
        children: [
          ListProducts(products: controller.categoryProducts),
        ],
      ),
    );
  }
}
