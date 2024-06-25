import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elzo_wear/controllers/home_controller.dart';
import 'package:elzo_wear/core/app_routs.dart';
import 'package:elzo_wear/models/product_model.dart';

class ListProducts extends GetView<HomeController> {
  const ListProducts({super.key, required this.products});

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      children: products.map(
        (product) {
          double rate = 0;
          for (var item in product.rate!) {
            rate = (rate + (item.quality! + item.price!) / 2);
          }
          product.rate!.isNotEmpty ? rate = rate/product.rate!.length : null;
          bool isLiked = controller.isLiked(product.likes!);
          return GestureDetector(
            onTap: () async{
              Get.toNamed(AppRouts.productScreen, arguments: product);
            },
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: ((Get.width - 60) / 2),
                      height: ((Get.width - 60) / 2) * 2.1,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: ((Get.width - 60) / 2) - 30,
                            height: ((Get.width - 60) / 2) - 30,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Hero(
                                tag: product.objectId!,
                                child: Image.network(
                                  product.image!.url!,
                                  width: ((Get.width - 60) / 2) - 30,
                                  height: ((Get.width - 60) / 2) - 30,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: ((Get.width - 60) / 2) - 30,
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  width: ((Get.width - 60) / 2) - 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 30,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                              size: 26,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            (rate != 0)
                                                ? Text(
                                                    rate.toStringAsFixed(
                                                        2),
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: (rate == 0)
                                                          ? Colors.black
                                                              .withOpacity(
                                                                  0.5)
                                                          : (rate >= 1 &&
                                                                  rate <
                                                                      2)
                                                              ? Colors.red
                                                              : (rate >= 2 &&
                                                                      rate <
                                                                          3)
                                                                  ? Colors
                                                                      .orange
                                                                  : (rate >= 3 &&
                                                                          rate < 4)
                                                                      ? Colors.green[500]
                                                                      : Colors.green[800],
                                                    ),
                                                  )
                                                : const Text('-.-'),
                                            const Spacer(),
                                            GetBuilder<HomeController>(
                                              builder: (builder) {
                                                return Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      '( ${product.likes!.length} )',
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        if (isLiked) {
                                                          controller.likeUnlike(product, true, controller.user!.objectId!);
                                                          isLiked = !isLiked;
                                                        }
                                                        else{
                                                          controller.likeUnlike(product, false, controller.user!.objectId!);
                                                          isLiked = !isLiked;
                                                        }
                                                      },
                                                      child: Container(
                                                        child: (isLiked)
                                                            ? const Icon(
                                                          Iconsax.heart5,
                                                          color:
                                                          Colors.red,
                                                          size: 24,
                                                        )
                                                            : const Icon(
                                                          Iconsax.heart,
                                                          color:
                                                          Colors.red,
                                                          size: 24,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Iconsax.shopping_bag,
                                              color: Colors.black,
                                              size: 24,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              product.buyCounter!
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                            const Spacer(),
                                            GetBuilder<HomeController>(
                                                builder: (builder) {
                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    '( ${product.comments!.length} )',
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      controller.showComments(
                                                          product);
                                                    },
                                                    child: const Icon(
                                                        Icons.comment_outlined,
                                                        size: 24),
                                                  ),
                                                ],
                                              );
                                            }),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(

                                  width: ((Get.width - 60) / 2) - 30,
                                  child: Text(
                                    product.title!,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Divider(
                                  color: Colors.black.withOpacity(0.1),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 7.5),
                                  width: (((Get.width - 60) / 2) - 30) * 2 / 3,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Text(
                                    '\$ ${product.price!.toStringAsFixed(1)}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    product.stock == 0
                        ? Container(
                            alignment: Alignment.center,
                            width: ((Get.width - 60) / 2),
                        height: ((Get.width - 60) / 2) * 2.1,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.35),
                                borderRadius: BorderRadius.circular(20)),
                            child: const Column(
                              children: [
                                Spacer(),
                                Text(
                                  'Unavailable',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Spacer(),
                              ],
                            ))
                        : const SizedBox(),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        },
      ).toList(),
    );
  }
}
