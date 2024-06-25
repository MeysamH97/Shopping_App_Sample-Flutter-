import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elzo_wear/controllers/home_controller.dart';
import 'package:elzo_wear/models/category_model.dart';
import 'package:elzo_wear/view/widgets/Text_Filed_widget.dart';
import 'package:elzo_wear/view/widgets/base_widget.dart';
import 'package:elzo_wear/view/widgets/list_products.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (builder) {
        if (controller.user == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(width: 1)),
                  child: CircleAvatar(
                    radius: 25,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: controller.user!.imageAddress == null
                          ? Image.asset('assets/Images/user.jpg')
                          : Image.network(
                              controller.user!.imageAddress!,
                              fit: BoxFit.fill,
                            ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Good Morning',
                          style: TextStyle(fontSize: 14),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          controller.user!.username!,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          body: BaseWidget(
            children: [
              CustomTextField(
                controller: controller.searchController,
                hint: 'Search',
                prefixIcon: const Icon(Iconsax.search_favorite),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Text(
                    'Special Offers',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'See All',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              CarouselSlider(
                items: controller.sliders.map((slide) {
                  return ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                    child: Image.network(slide.url,
                        height: Get.width / 2,
                        fit: BoxFit.fill),
                  );
                }).toList(),
                options: CarouselOptions(
                  height: Get.width / 2,
                  autoPlay: true,
                  // viewportFraction: 1.1,
                  aspectRatio: 16 / 9,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: true,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Categories",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              Wrap(
                children: controller.categories.map(
                  (category) {
                    return GestureDetector(
                      onTap: () {
                        controller.navigateToCategoryScreen(category);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        width: Get.height / 9,
                        height: Get.height * 1.75 / 9,
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              width: (Get.height / 9) - 10,
                              height: (Get.height / 9) - 10,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  category.image!.url!,
                                ),
                              ),
                            ),
                            const Divider(),
                            Container(
                              alignment: Alignment.center,
                              width: (Get.height / 9) - 10,
                              height: 40,
                              child: Text(
                                category.title!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Text(
                    'Most Favorites',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'See All',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(5),
                alignment: Alignment.center,
                width: Get.width - 40,
                height: 55,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    Category category = controller.categoriesOfChip[index];
                    return SingleChildScrollView(
                      child: GestureDetector(
                        onTap: () {
                          controller.productsListUpdate(index, category);
                        },
                        child: Chip(
                          label: Text(
                            category.title!,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          side: const BorderSide(
                            width: 1,
                            color: Colors.black,
                          ),
                          backgroundColor:
                              controller.currentCategoryIndex == index
                                  ? Colors.black
                                  : Colors.grey.shade300,
                          labelStyle: TextStyle(
                            color: controller.currentCategoryIndex == index
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      width: 10,
                    );
                  },
                  itemCount: controller.categoriesOfChip.length,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ListProducts(
                  products: controller.currentCategoryIndex == 0
                      ? controller.products
                      : controller.productsOfChip),
            ],
          ),
        );
      },
    );
  }
}
