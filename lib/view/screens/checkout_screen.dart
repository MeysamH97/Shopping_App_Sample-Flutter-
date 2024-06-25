import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:elzo_wear/controllers/checkout_controller.dart';
import 'package:elzo_wear/core/app_routs.dart';
import 'package:elzo_wear/models/product_model.dart';
import 'package:elzo_wear/view/widgets/Button_widget.dart';
import 'package:elzo_wear/view/widgets/Text_Filed_widget.dart';
import 'package:elzo_wear/view/widgets/base_widget.dart';

class CheckoutScreen extends GetView<CheckoutController> {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckoutController>(
      builder: (builder) {
        if (controller.showLoadingIcon) {
          controller.showLoading();
          return Center(
            child: Lottie.asset(
              'assets/Animations/Payment.json',
              width: 300,
              height: 300,
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Complete Your Order',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                const Spacer(),
                Lottie.asset('assets/Animations/Payment.json',
                    width: 65, height: 65),
              ],
            ),
          ),
          body: BaseWidget(
            crossAxisAlignment: CrossAxisAlignment.start,
            bottomNavBar: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              padding: const EdgeInsets.all(20),
              child: CustomButton(
                color: Colors.black,
                onTap: () async {
                  await controller.creatOrder();
                  // Get.toNamed(AppRouts.paymentScreen);
                },
                text: 'Continue to payment',
                fontSize: 18,
                icon: Iconsax.card,
              ),
            ),
            children: [
              Divider(
                color: Colors.black.withOpacity(0.1),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                'Shipping Address ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black.withOpacity(0.05),
                ),
                child: Row(
                  children: [
                    Container(
                      width: (Get.width-60)/7,
                      height: (Get.width-60)/7,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black.withOpacity(0.1)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Lottie.asset(
                          'assets/Animations/Location2.json',
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Address Title',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.black),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Your  Address',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black.withOpacity(0.5)),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: (Get.width-60)/7,
                      height: (Get.width-60)/7,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black.withOpacity(0.05)),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Iconsax.edit,
                        ),
                        highlightColor: Colors.black.withOpacity(0.1),
                        hoverColor: Colors.black.withOpacity(0.05),
                        style: const ButtonStyle(
                            iconSize: MaterialStatePropertyAll(25)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Divider(
                color: Colors.black.withOpacity(0.1),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                'Order List',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ...controller.products!.map(
                (Map item) {
                  Product product = item['product'] as Product;
                  return SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(vertical: 5 , horizontal: 0),
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
                              width: (Get.width-60)/7,
                              height: (Get.width-60)/7,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  product.title!,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '\$ ${product.price!.toDouble()}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black.withOpacity(0.5),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                              width: (Get.width-60)/7,
                              height: (Get.width-60)/7,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.black.withOpacity(0.05)),
                              child: Center(
                                child: Text(
                                  '${item['count']}',
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.black),
                                ),
                              )),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 5,
              ),
              Divider(
                color: Colors.black.withOpacity(0.1),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                'Choose Shipping',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: controller.shippingResult == 0
                      ? Colors.black.withOpacity(0.05)
                      : Colors.lightGreen.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Container(
                        width: (Get.width-60)/7,
                        height: (Get.width-60)/7,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black.withOpacity(0.05)),
                        child: Lottie.asset('assets/Animations/Shipping.json')),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black.withOpacity(0.05)),
                        child: Text(controller.shippingTitle == 'Choose Shipping type'?
                        controller.shippingTitle :'${controller.shippingTitle} Delivery',
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: (Get.width-60)/7,
                      height: (Get.width-60)/7,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black.withOpacity(0.05)),
                      child: IconButton(
                        onPressed: () {
                          Get.toNamed(AppRouts.shippingScreen);
                        },
                        icon: const Icon(
                          Iconsax.arrow_right,
                        ),
                        highlightColor: Colors.black.withOpacity(0.1),
                        hoverColor: Colors.black.withOpacity(0.05),
                        style: const ButtonStyle(
                            iconSize: MaterialStatePropertyAll(25)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Divider(
                color: Colors.black.withOpacity(0.1),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                'Promo Code',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: controller.promoResult == 0
                      ? Colors.black.withOpacity(0.05)
                      : controller.promoResult == 1
                          ? Colors.lightGreen.withOpacity(0.5)
                          : Colors.redAccent.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Container(
                        width: (Get.width-60)/7,
                        height: (Get.width-60)/7,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black.withOpacity(0.05)),
                        child: Lottie.asset('assets/Animations/Promo.json')),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: CustomTextField(
                        controller: controller.promoTextController,
                        hint: 'Enter your promo code',
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: (Get.width-60)/7,
                      height: (Get.width-60)/7,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black.withOpacity(0.05)),
                      child: IconButton(
                        onPressed: () {
                          controller.checkPromo(
                              controller.promoTextController.text);
                        },
                        icon: const Icon(
                          Iconsax.add_circle,
                          color: Colors.black,
                        ),
                        highlightColor: Colors.green.withOpacity(0.3),
                        hoverColor: Colors.green.withOpacity(0.1),
                        style: const ButtonStyle(
                            iconSize: MaterialStatePropertyAll(25)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Divider(
                color: Colors.black.withOpacity(0.1),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Products Price :',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '\$ ${controller.total.toDouble()}',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Shipping Price :',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '\$ ${controller.shippingPrice.toDouble()}',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Promo :',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '- \$ ${controller.promoPrice.toDouble()}',
                          style: TextStyle(
                            color: controller.promoPrice == 0
                                ? Colors.black.withOpacity(0.5)
                                : Colors.green,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Divider(
                      color: Colors.black.withOpacity(0.1),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Price :',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '\$ ${controller.total + controller.shippingPrice - controller.promoPrice}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
