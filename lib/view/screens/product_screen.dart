import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elzo_wear/controllers/product_controller.dart';
import 'package:elzo_wear/view/widgets/Button_widget.dart';

class ProductScreen extends GetView<ProductController> {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Iconsax.arrow_left,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Hero(
                tag: controller.product.objectId!,
                child: Image.network(
                  controller.product.image!.url!,
                  width: Get.height/2.5,
                  height: Get.height/2.5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 20),
                child: Column(
                  children: [
                    Text(
                      controller.product.title!,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Divider(color: Colors.grey.withOpacity(0.25)),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Description:',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Text(
                      controller.product.description!,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Divider(color: Colors.grey.withOpacity(0.25)),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          'Quantity in stock:',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade600),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: Get.height/6,
                          height: Get.height/15,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius:
                            const BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: Text(
                            '${controller.product.stock}',
                            textAlign:
                            TextAlign.center,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight:
                                FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          'Product Price:',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade600),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          '\$ ${(controller.product.price!).toStringAsFixed(2)}',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.7)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      children: [
                        Text(
                          'Order quantity :',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade600),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GetBuilder<ProductController>(
                            builder: (builder) {
                              return Container(
                                width: Get.height/6,
                                height: Get.height/15,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius:
                                  const BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        controller.counterReduce();
                                        controller.getSum();
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: (Get.height/6)*1.5/5,
                                        child: const Icon(
                                          Iconsax.minus,
                                          color: Colors.black,
                                          size: 26,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: (Get.height/6)*2/5,
                                      child: Text(
                                        '${controller.productCounter}',
                                        textAlign:
                                        TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight:
                                            FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        controller.counterPlus();
                                        controller.getSum();
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: (Get.height/6)*1.5/5,
                                        child: const Icon(
                                          Iconsax.add,
                                          color: Colors.black,
                                          size: 26,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Divider(color: Colors.black.withOpacity(0.25)),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Total Price:',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade600),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GetBuilder<ProductController>(builder: (builder) {
                              return Text(
                                '\$ ${controller.productSum.toStringAsFixed(2)}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              );
                            }),
                          ],
                        ),
                        const SizedBox(width: 50,),
                        Expanded(
                          child: CustomButton(
                            color: Colors.black,
                            onTap: () {
                              controller.product.stock !=0 ? controller.addToCart(): null ;
                            },
                            text: controller.product.stock !=0 ? 'Add To Cart': 'Unavailable',
                            fontSize: 18,
                            icon: Iconsax.shopping_bag,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
