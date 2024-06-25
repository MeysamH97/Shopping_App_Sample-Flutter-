import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:elzo_wear/controllers/checkout_controller.dart';
import 'package:elzo_wear/view/widgets/Button_widget.dart';
import 'package:elzo_wear/view/widgets/base_widget.dart';
import 'package:elzo_wear/view/widgets/radio_botton_generator.dart';

class ShippingScreen extends GetView<CheckoutController> {
  const ShippingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CheckoutController>(
        builder: (builder) {
          return Scaffold(
            appBar: AppBar( title: const Text(
              'Choose shipping method',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),),
            body: BaseWidget(
              children: [
                ...Shipping.values.map(
                  (shipping) {
                    return RadioButtonGenerator(
                      color: Colors.black,
                      icon: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Lottie.asset(
                          'assets/Animations/Shipping.json',
                        ),
                      ),
                      title: shipping.name,
                      info: shipping.info,
                      amount: shipping.amount,
                      radioWidget: Radio<Shipping>(
                        value: shipping,
                        groupValue: controller.shipping,
                        onChanged: (Shipping? value) {
                          controller.shipping = value!;
                          controller.update();
                        },
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
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      width: (Get.width-40)/2,
                      color: Colors.black.withOpacity(0.1),
                      onTap: () => Get.back(),
                      text: 'Cancel',
                      textColor: Colors.black,
                      fontSize: 14,
                    ),
                    CustomButton(
                      width: (Get.width-40)/2,
                      color: Colors.black,
                      onTap: () {controller.exportShippingDetails();},
                      text: 'Apply',
                      fontSize: 14,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
