import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:elzo_wear/controllers/order_controller.dart';
import 'package:elzo_wear/view/widgets/base_widget.dart';

class OrderScreen extends GetView<OrderController> {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
      init: OrderController(),
      builder: (controller) {
        if (controller.showLoadingIcon) {
          return Center(
            child: Lottie.asset(
              'assets/Animations/Orders.json',
              width: 500,
              height: 500,
            ),
          );
        }
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        'assets/Animations/Orders.json',
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
                            'Orders History',
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
              bottom: TabBar(
                labelStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
                overlayColor: MaterialStatePropertyAll(
                  Colors.black.withOpacity(0.1),
                ),
                indicatorColor: Colors.black,
                onTap: (value) {
                  for (var item in controller.ongoingOrders!) {
                    item['show_details'] = false;
                  }
                  for (var item in controller.completedOrders!) {
                    item['show_details'] = false;
                  }
                  controller.update();
                },
                tabs: const [
                  Tab(
                    text: 'Ongoing',
                  ),
                  Tab(
                    text: 'Completed',
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                BaseWidget(
                  padding: 10,
                  children: [
                    if (controller.ongoingOrders!.isEmpty) ...{
                      Center(
                      child : Image.asset(
                        'assets/Images/Empty_order.jpg',
                        width: Get.width,
                        height: Get.width,
                      ),)
                    } else ...{
                      ...controller.ongoingOrders!.map(
                        (Map order) {
                          return SingleChildScrollView(
                            child: controller.creatTabViewSections(order),
                          );
                        },
                      ),
                    },
                  ],
                ),
                BaseWidget(
                  padding: 10,
                  children: [
                    if (controller.completedOrders!.isEmpty) ...{
                      Image.asset(
                        'assets/Images/Empty_order.jpg',
                        width: Get.width,
                        height: Get.width,
                      ),
                    } else ...{
                      ...controller.completedOrders!.map(
                        (Map order) {
                          return SingleChildScrollView(
                            child: controller.creatTabViewSections(order),
                          );
                        },
                      ),
                    },
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
