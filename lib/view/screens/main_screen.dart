import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elzo_wear/controllers/cart_controller.dart';
import 'package:elzo_wear/controllers/home_controller.dart';

class MainScreen extends GetView<HomeController> {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HomeController>(
        builder: (builder) {
          return controller.screens[controller.currentButtonNavigationIndex];
        },
      ),
      bottomNavigationBar: GetBuilder<HomeController>(
        builder: (builder) {
          return BottomNavigationBar(
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Iconsax.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Stack(
                  children: [
                    const Icon(Iconsax.shopping_bag),
                    CartController().productsCounter > 0 ? Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.red,
                        ),
                        width: 18,
                        height: 18,
                        child: GetBuilder<HomeController>(builder: (logic) {
                          return Text(
                            '${controller.cartCounter}',
                            style: const TextStyle(
                              fontSize: 9,
                              color: Colors.white,
                            ),
                          );
                        }),
                      ),
                    ) : const SizedBox(width: 0,height: 0,),
                  ],
                ),
                label: 'Cart',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Iconsax.shopping_cart),
                label: 'Orders',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Iconsax.user),
                label: 'Profile',
              ),
            ],
            currentIndex: controller.currentButtonNavigationIndex,
            onTap: (index) {
              controller.currentButtonNavigationIndex = index;
              controller.update();
            },
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            iconSize: 35,
          );
        },
      ),
    );
  }
}
