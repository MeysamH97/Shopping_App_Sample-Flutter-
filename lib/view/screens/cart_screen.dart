import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:elzo_wear/controllers/cart_controller.dart';
import 'package:elzo_wear/core/app_routs.dart';
import 'package:elzo_wear/models/product_model.dart';
import 'package:elzo_wear/view/widgets/Button_widget.dart';
import 'package:elzo_wear/view/widgets/base_widget.dart';

class CartScreen extends GetView<CartController> {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      init: CartController(),
      builder: (controller) {
        if (controller.showLoadingIcon) {
          return Container(
            alignment: Alignment.center,
            width: Get.width,
            height: Get.height,
            child: Lottie.asset(
              'assets/Animations/cart2.json',
              width: Get.height > Get.height? Get.height/2:Get.height/2,
              height: Get.height > Get.height? Get.height/2:Get.height/2,
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/Animations/cart2.json',
                      width: 65,
                      height: 65,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'My Cart',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    const Icon(Iconsax.search_normal),
                  ],
                ),
              ],
            ),
          ),
          body: BaseWidget(
            padding: 10,
            bottomNavBar: controller.cart.objectId == null
                ? null
                : Container(
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.025),
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              'Total Price :',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.4),
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GetBuilder<CartController>(builder: (builder) {
                              return Text(
                                '\$ ${controller.cart.total!.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              );
                            }),
                          ],
                        ),
                        const SizedBox(width: 50),
                        Expanded(
                          child: CustomButton(
                            color: Colors.black,
                            onTap: () {
                              Get.offNamed(
                                AppRouts.checkoutScreen,
                                arguments: controller.products,
                                parameters: {
                                  'total': controller.cart.total!.toStringAsFixed(1),
                                },
                              );
                            },
                            text: 'Continue',
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
            children: [
              Divider(
                color: Colors.black.withOpacity(0.1),
              ),
              if (controller.cart.productsInCart == null) ...{
                Container(
                  height: Get.height-165,
                  width: Get.width-40,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/Images/Empty_cart.jpg',
                        width: Get.height > Get.height? Get.height/2:Get.height/2,
                        height: Get.height > Get.height? Get.height/2:Get.height/2,
                      ),
                    ],
                  ),
                ),
              } else ...{
                ...controller.products!.map(
                  (Map item) {
                    Product product = item['product'] as Product;
                    return SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.025),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                product.image!.url!,
                                width: (Get.height) / 8,
                                height: (Get.height) / 8,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          product.title!,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          color: Colors.red.withOpacity(0.1),
                                        ),
                                        child: IconButton(
                                          onPressed: () {
                                            Get.bottomSheet(
                                              Container(
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                          top: Radius.circular(
                                                              20)),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    const SizedBox(height: 10,),
                                                    const Text(
                                                      'Remove from cart ?',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Divider(
                                                      color: Colors.black
                                                          .withOpacity(0.1),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.all(10),
                                                      margin: const EdgeInsets.all(5),
                                                      decoration: BoxDecoration(
                                                        color: Colors.black.withOpacity(0.025),
                                                        borderRadius: BorderRadius.circular(20),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius: BorderRadius.circular(20),
                                                            child: Image.network(
                                                              product.image!.url!,
                                                              width: (Get.width - 40) / 4,
                                                              height: (Get.width - 40) / 4,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              mainAxisAlignment:
                                                              MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Text(
                                                                  product.title!,
                                                                  style: const TextStyle(
                                                                    color: Colors.black,
                                                                    fontSize: 14,
                                                                    fontWeight: FontWeight.bold,
                                                                  ),
                                                                  overflow: TextOverflow.ellipsis,
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Column(
                                                                      children: [
                                                                        Text(
                                                                          '\$ ${product.price!.toStringAsFixed(2)}',
                                                                          style: TextStyle(
                                                                            fontSize: 14,
                                                                            color:
                                                                            Colors.black.withOpacity(0.5),
                                                                            fontWeight: FontWeight.bold,
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          height: 10,
                                                                        ),
                                                                        GetBuilder<CartController>(
                                                                            builder: (builder) {
                                                                              return Container(
                                                                                width: (((Get.width - 40)*3/4)-10) * 3/7,
                                                                                height: Get.height/20,
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
                                                                                        if (item['count'] > 1) {
                                                                                          item['count']--;
                                                                                          controller.updateCart(
                                                                                              product.objectId!,
                                                                                              item['count']);
                                                                                          controller.update();
                                                                                        }
                                                                                      },
                                                                                      child: Container(
                                                                                        alignment: Alignment.center,
                                                                                        width: ((((Get.width - 40)*3/4)-10) * 3/7)*1.5/5,
                                                                                        child: const Icon(
                                                                                          Iconsax.minus,
                                                                                          color: Colors.black,
                                                                                          size: 20,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: ((((Get.width - 40)*3/4)-10) * 3/7)*2/5,
                                                                                      child: Text(
                                                                                        '${item['count']}',
                                                                                        textAlign:
                                                                                        TextAlign.center,
                                                                                        style: const TextStyle(
                                                                                            fontSize: 14,
                                                                                            fontWeight:
                                                                                            FontWeight.bold,
                                                                                            color: Colors.black),
                                                                                      ),
                                                                                    ),
                                                                                    GestureDetector(
                                                                                      onTap: () {
                                                                                        item['count']++;
                                                                                        controller.updateCart(
                                                                                            product.objectId!,
                                                                                            item['count']);
                                                                                        controller.update();
                                                                                      },
                                                                                      child: Container(
                                                                                        alignment: Alignment.center,
                                                                                        width: ((((Get.width - 40)*3/4)-10) * 3/7)*1.5/5,
                                                                                        child: const Icon(
                                                                                          Iconsax.add,
                                                                                          color: Colors.black,
                                                                                          size: 20,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              );
                                                                            }),
                                                                      ],
                                                                    ),
                                                                    Column(
                                                                      children: [
                                                                        const Text(
                                                                          'Total',
                                                                          style: TextStyle(
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: 14,
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          height: 10,
                                                                        ),
                                                                        Container(
                                                                          width: (((Get.width - 40)*3/4)-10) * 3/7,
                                                                          height: Get.height/20,
                                                                          padding: const EdgeInsets.symmetric(
                                                                              vertical: 10, horizontal: 10),
                                                                          decoration: const BoxDecoration(
                                                                            color: Colors.black,
                                                                            borderRadius: BorderRadius.all(
                                                                              Radius.circular(20),
                                                                            ),
                                                                          ),
                                                                          child: Text(
                                                                            '\$ ${item['count'] * product.price!.toDouble()}',
                                                                            textAlign: TextAlign.center,
                                                                            style: const TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Divider(
                                                      color: Colors.black
                                                          .withOpacity(0.1),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: CustomButton(
                                                            fontSize: 16,
                                                            textColor:
                                                                Colors.black,
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.1),
                                                            onTap: () {
                                                              Get.back();
                                                            },
                                                            text: 'Cancel',
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Expanded(
                                                          child: CustomButton(
                                                            fontSize: 16,
                                                            color: Colors.black,
                                                            onTap: () {
                                                              controller
                                                                  .removeFromCart(
                                                                      product
                                                                          .objectId!);
                                                              controller
                                                                  .update();
                                                              Get.back();
                                                            },
                                                            text: 'Yes, Remove',
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                          icon: const Icon(Iconsax.trash),
                                          highlightColor:
                                              Colors.red.withOpacity(0.5),
                                          hoverColor:
                                              Colors.red.withOpacity(0.25),
                                          style: const ButtonStyle(
                                              iconSize:
                                                  MaterialStatePropertyAll(25)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            '\$ ${product.price!.toStringAsFixed(2)}',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          GetBuilder<CartController>(
                                              builder: (builder) {
                                            return Container(
                                              width: Get.height/8,
                                              height: Get.height/20,
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
                                                      if (item['count'] > 1) {
                                                        item['count']--;
                                                        controller.updateCart(
                                                            product.objectId!,
                                                            item['count']);
                                                        controller.update();
                                                      }
                                                    },
                                                    child: Container(
                                                      alignment: Alignment.center,
                                                      width: (Get.height/8)*1.5/5,
                                                      child: const Icon(
                                                        Iconsax.minus,
                                                        color: Colors.black,
                                                        size: 22,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: (Get.height/8)*2/5,
                                                    child: Text(
                                                      '${item['count']}',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      if (item['count'] < product.stock) {
                                                        item['count']++;
                                                        controller.updateCart(
                                                            product.objectId!,
                                                            item['count']);
                                                        controller.update();
                                                      }
                                                    },
                                                    child: Container(
                                                      alignment: Alignment.center,
                                                      width: (Get.height/8)*1.5/5,
                                                      child: const Icon(
                                                        Iconsax.add,
                                                        color: Colors.black,
                                                        size: 22,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          const Text(
                                            'Total',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            width: Get.height/8,
                                            height: Get.height/20,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 10),
                                            decoration: const BoxDecoration(
                                              color: Colors.black,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20),
                                              ),
                                            ),
                                            child: Text(
                                              '\$ ${item['count'] * product.price!.toDouble()}',
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              },
            ],
          ),
        );
      },
    );
  }
}
