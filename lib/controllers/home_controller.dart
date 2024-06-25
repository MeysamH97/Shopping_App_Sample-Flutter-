import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:elzo_wear/core/app_routs.dart';
import 'package:elzo_wear/core/constants.dart';
import 'package:elzo_wear/models/cart_model.dart';
import 'package:elzo_wear/models/category_model.dart';
import 'package:elzo_wear/models/product_model.dart';
import 'package:elzo_wear/models/promotion_slider.dart';
import 'package:elzo_wear/models/user_model.dart';
import 'package:elzo_wear/view/screens/cart_screen.dart';
import 'package:elzo_wear/view/screens/home_screen.dart';
import 'package:elzo_wear/view/screens/order_screen.dart';
import 'package:elzo_wear/view/screens/profile_screen.dart';
import 'package:elzo_wear/view/widgets/Text_Filed_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  int currentButtonNavigationIndex = 0;

  List<Widget> screens = [
    const HomeScreen(),
    const CartScreen(),
    const OrderScreen(),
    const ProfileScreen(),
  ];

  int currentCategoryIndex = 0;
  TextEditingController searchController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  List<promotion_slider> sliders = [];
  List<Category> categories = [];
  List<Category> categoriesOfChip = [];
  List<Product> products = [];
  List<Product> productsOfChip = [];
  List<String>? productsLikes = [];

  User? user;
  Cart? cart;
  int cartCounter = 0;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUser();
    getUserData();
    getSlider();
    getCategories();
    getProducts();
  }

  void getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString(Constants.userId) ?? '-1';
    var response = await http.get(
      Uri.parse('https://parseapi.back4app.com/users/$userId'),
      headers: Constants.header,
    );

    Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      user = User.fromJson(data);
      update();
    } else {
      Get.snackbar("Error", data['error'], backgroundColor: Colors.white);
    }
  }

  void getSlider() async {
    var response = await http.get(
      Uri.parse('https://parseapi.back4app.com/classes/slider'),
      headers: Constants.header,
    );
    List data = jsonDecode(response.body)['results'];
    if (response.statusCode == 200) {
      sliders =
          data.map((slider) => promotion_slider.fromJson(slider)).toList();
      update();
    }
  }

  void getCategories() async {
    var response = await http.get(
      Uri.parse('https://parseapi.back4app.com/classes/Category'),
      headers: Constants.header,
    );
    List data = jsonDecode(response.body)['results'];
    if (response.statusCode == 200) {
      categoriesOfChip.add(Category(objectId: '-1', title: 'All'));
      for (var item in data) {
        categories.add(Category.fromJson(item));
        categoriesOfChip.add(Category.fromJson(item));
      }
      update();
    }
  }

  void getProducts() async {
    var response = await http.get(
      Uri.parse('https://parseapi.back4app.com/classes/Products'),
      headers: Constants.header,
    );
    List data = jsonDecode(response.body)['results'];
    if (response.statusCode == 200) {
      products = data.map((product) => Product.fromJson(product)).toList();
      update();
    }
  }

  productsListUpdate(int index, Category category) async {
    currentCategoryIndex = index;
    update();
    getProducts();
    if (category.objectId != '-1') {
      List<Product> newList = [];
      for (var item in products) {
        if (item.categoryId == category.objectId) {
          newList.add(item);
        }
      }
      productsOfChip.clear();
      productsOfChip = newList;
    }
    update();
  }

  void navigateToCategoryScreen(Category category) async {
    getProducts();
    update();
    List<Product> newList = [];
    for (var item in products) {
      if (item.categoryId == category.objectId) {
        newList.add(item);
      }
    }
    Get.toNamed(
      AppRouts.categoryScreen,
      arguments: newList,
      parameters: {'title': category.title!},
    );
  }

  getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString(Constants.userId) ?? '-1';
    var response = await http.get(
      Uri.parse('https://parseapi.back4app.com/classes/cart'),
      headers: Constants.header,
    );

    Map data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (var item in data['results']) {
        if (item['userId']['objectId'] == userId) {
          prefs.setString(Constants.cartId, item['objectId']);
        }
      }
      response = await http.get(
        Uri.parse('https://parseapi.back4app.com/classes/Orders_list'),
        headers: Constants.header,
      );
      data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        for (var item in data['results']) {
          if (item['userId']['objectId'] == userId) {
            prefs.setString(Constants.ordersListId, item['objectId']);
          }
        }
      }
    }
  }

  void showComments(Product product) {
    Get.bottomSheet(
      GetBuilder<HomeController>(builder: (builder) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Comments  ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
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
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...product.comments!
                          .map(
                            (Comments comment) {
                          return Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(width: 2),
                                  ),
                                  child: CircleAvatar(
                                    radius: 30,
                                    child: ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(30),
                                      child: (comment.user!.imageAddress) ==
                                          null
                                          ? Image.asset(
                                          'assets/Images/user.jpg')
                                          : Image.network(
                                          comment.user!.imageAddress!),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${comment.user!.username} :',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 30,
                                          ),
                                          Text(
                                            comment.comment!,
                                            style: TextStyle(
                                              color: Colors.black
                                                  .withOpacity(0.7),
                                              fontSize: 14,
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
                      )
                          .toList()
                          .reversed,
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Divider(
                    color: Colors.black.withOpacity(0.1),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: Get.width - 85,
                        child: CustomTextField(
                          maxLines: null,
                          maxLength: 250,
                          prefixIcon: const Icon(
                            Icons.comment_bank_outlined,
                          ),
                          controller: commentController,
                          hint: 'Add your comment',
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 40,
                        child: Column(
                          children: [
                            IconButton(
                              alignment: Alignment.center,
                              onPressed: () {
                                addComment(product, commentController.text);
                                commentController.clear();
                              },
                              icon: const Icon(
                                Icons.send,
                                size: 30,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        );
      }),
    );
  }

  void addComment(Product product, String comment) async {
    Product newProduct = Product(
      likes: product.likes,
      title: product.title,
      image: ProductImage(
        name: product.image!.name,
        sType: product.image!.sType,
        url: product.image!.url,
      ),
      categoryId: product.categoryId,
      description: product.description,
      price: product.price,
      stock: product.stock,
      rate: product.rate,
      buyCounter: product.buyCounter,
      comments: product.comments!
        ..add(
          Comments(
            user: user,
            comment: comment,
          ),
        ),
    );

    var response = await http.put(
      Uri.parse(
          'https://parseapi.back4app.com/classes/Products/${product.objectId}'),
      headers: Constants.header3,
      body: jsonEncode(newProduct.toJson()),
    );
    if (response.statusCode != 200) {
      Get.snackbar("Error", jsonDecode(response.body)['error']);
    } else {
      getUser();
      update();
    }
  }

  isLiked(List likes) {
    for (var item in likes) {
      if (item == user!.objectId!) {
        return true;
      }
    }
      return false;
  }

  void likeUnlike(Product product, bool isLiked, String userId) async {
    List<String> newLikes = product.likes!;
    if (isLiked) {
      newLikes.remove(userId);
      update();
    } else {
      newLikes.add(userId);
      update();
    }

    String productId = product.objectId!;
    Product newProduct = Product(
      likes: newLikes,
      objectId: product.objectId,
      title: product.title,
      image: ProductImage(
        name: product.image!.name,
        sType: product.image!.sType,
        url: product.image!.url,
      ),
      categoryId: product.categoryId,
      description: product.description,
      price: product.price,
      stock: product.stock,
      rate: product.rate!,
      buyCounter: product.buyCounter,
      comments: product.comments!,
    );
    await http.put(
      Uri.parse('https://parseapi.back4app.com/classes/Products/$productId'),
      headers: Constants.header3,
      body: jsonEncode(newProduct.toJson()),
    );
  }

}
