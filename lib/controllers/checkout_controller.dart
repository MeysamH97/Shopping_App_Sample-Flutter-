import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:elzo_wear/core/app_routs.dart';
import 'package:elzo_wear/core/constants.dart';
import 'package:elzo_wear/models/order_model.dart';
import 'package:elzo_wear/models/ordersList_model.dart';
import 'package:elzo_wear/models/product_model.dart';
import 'package:elzo_wear/view/widgets/Button_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckoutController extends GetxController {
  List<Map>? products = Get.arguments ?? [];
  double total = double.parse(Get.parameters['total'] ?? '0.0');

  bool showLoadingIcon = true;

  int shippingPrice = 0;
  String shippingTitle = 'Choose Shipping type';
  Shipping shipping = Shipping.economy;
  int shippingResult = 0;

  TextEditingController promoTextController = TextEditingController();
  double promoPrice = 0;
  int promoResult = 0;

  Order order = Order();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Future.delayed(
      const Duration(seconds: 1),
      () {
        showLoading();
      },
    );
  }

  void showLoading() {
    showLoadingIcon = false;
    update();
  }

  void exportShippingDetails() {
    shippingTitle = shipping.name;
    shippingPrice = shipping.amount;
    shippingResult = 1;
    update();
    Get.back();
  }

  void checkPromo(String code) async {
    promoTextController.text = '';
    promoResult = 0;
    promoPrice = 0;
    update();
    var response = await http.get(
        Uri.parse('https://parseapi.back4app.com/classes/promo_cods'),
        headers: Constants.header);
    Map data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      for (var item in data['results']) {
        if (item['objectId'] == code) {
          promoPrice = total * item['discount_percent'] / 100;
          promoTextController.text = ('Promo Applied ( ${item['objectId']} )');
          promoResult = 1;
          update();
        } else {
          promoTextController.text = 'The code you entered is not exist';
          promoResult = -1;
          update();
        }
      }
    } else {
      Get.snackbar("Error", jsonDecode(response.body)['error'],
          backgroundColor: Colors.white);
    }
  }

  Future<void> creatOrder() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    updateProduct();

    String userId = prefs.getString(Constants.userId) ?? '';

    double finalTotal = total + shippingPrice - promoPrice;

    List<ProductsInOrder> newList = [];

    for (var item in products!) {
      Product product = item['product'] as Product;

      newList.add(
        ProductsInOrder(
          productId: product.objectId,
          count: item['count'],
        ),
      );
    }
    order.userId = userId;
    order.total = finalTotal.toInt();
    order.productsInOrder = newList;
    order.status = 'Ongoing';
    order.rate = '0.00';
    var response = await http.post(
        Uri.parse('https://parseapi.back4app.com/classes/Orders'),
        headers: Constants.header3,
        body: jsonEncode(order.toJson()));
    Map data = jsonDecode(response.body);
    if (response.statusCode == 201) {
      order.objectId = data['objectId'];
      Get.defaultDialog(
        title: 'Order Code : ${order.objectId}',
        titleStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        content: Column(
          children: [
            Lottie.asset(
              'assets/Animations/Success.json',
              width: 300,
              height: 300,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Order Successful',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'You have successfully made order',
              style: TextStyle(
                color: Colors.black.withOpacity(0.5),
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              color: Colors.black,
              onTap: () {
                addToOrdersList();
                clearCart();
                Get.back();
                Get.offNamed(AppRouts.homeScreen);
              },
              text: 'View Order',
              fontSize: 16,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomButton(
              color: Colors.black.withOpacity(0.05),
              onTap: () {
                addToOrdersList();
                clearCart();
                Get.back();
                Get.offNamed(AppRouts.homeScreen);
              },
              text: 'Make a new order',
              textColor: Colors.black,
              fontSize: 16,
            ),
          ],
        ),
      );
    } else {
      Get.snackbar("Error", jsonDecode(response.body)['error'],
          backgroundColor: Colors.white);
    }
  }

  void updateProduct() async {
    for (var item in products!) {
      String productId = item['product'].objectId;
      Product product = await getProduct(productId);
      Product newProduct = Product(
        likes: product.likes,
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
        stock: product.stock! - 1,
        rate: product.rate,
        buyCounter: product.buyCounter! + 1,
        comments: product.comments,
      );

      var response = await http.put(
        Uri.parse('https://parseapi.back4app.com/classes/Products/$productId'),
        headers: Constants.header3,
        body: jsonEncode(newProduct.toJson()),
      );
      if (response.statusCode != 200) {
        Get.snackbar("Error", jsonDecode(response.body)['error']);
      }
    }
  }

  Future<Product> getProduct(String productId) async {
    var response = await http.get(
      Uri.parse('https://parseapi.back4app.com/classes/Products/$productId'),
      headers: Constants.header,
    );
    return Product.fromJson(jsonDecode(response.body));
  }

  Future<void> addToOrdersList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? ordersListId = prefs.getString(Constants.ordersListId);
    String userId = prefs.getString(Constants.userId) ?? '-1';
    if (ordersListId == null) {
      creatNewOrdersList(userId);
    } else {
      updateOrdersList(ordersListId, userId);
    }
  }

  void creatNewOrdersList(String userId) async {
    OrdersList ordersList = OrdersList(
      userId: userId,
      orders: [
        Orders(
          orderId: order.objectId,
        ),
      ],
    );
    var response = await http.post(
      Uri.parse('https://parseapi.back4app.com/classes/Orders_list'),
      headers: Constants.header3,
      body: jsonEncode(ordersList.toJson()),
    );
    Map data = jsonDecode(response.body);
    if (response.statusCode == 201) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(Constants.ordersListId, data['objectId']);
      Get.snackbar('Result',
          'Order with code ( ${order.objectId} ) added to Orders List');
    } else {
      Get.snackbar("Error", data['error']);
    }
  }

  void updateOrdersList(String ordersListId, String userId) async {
    var response = await http.get(
      Uri.parse(
          'https://parseapi.back4app.com/classes/Orders_list/$ordersListId'),
      headers: Constants.header3,
    );
    OrdersList oldList = OrdersList.fromJson(jsonDecode(response.body));
    OrdersList ordersList = OrdersList(
      userId: userId,
      orders: oldList.orders!
        ..add(
          Orders(
            orderId: order.objectId,
          ),
        ),
    );
    var updateResponse = await http.put(
      Uri.parse(
          'https://parseapi.back4app.com/classes/Orders_list/$ordersListId'),
      headers: Constants.header3,
      body: jsonEncode(ordersList.toJson()),
    );

    Map data = jsonDecode(updateResponse.body);

    if (updateResponse.statusCode == 200) {
      Get.snackbar(
          'Result', 'Order with code ${order.objectId} added to Orders List');
    } else {
      Get.snackbar("Error", data['error']);
    }
  }

  void clearCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cartId = prefs.getString(Constants.cartId);
    var response = await http.delete(
      Uri.parse('https://parseapi.back4app.com/classes/cart/$cartId'),
      headers: Constants.header,
    );
    if (response.statusCode == 200) {
      prefs.remove(Constants.cartId);
    }
  }

}

enum Shipping {
  economy(10, 'Delivery in 2 weeks'),
  regular(15, 'Delivery in 10 days'),
  cargo(20, 'Delivery in a weak'),
  express(30, 'Delivery in 3 days');

  final int amount;
  final String info;

  const Shipping(this.amount, this.info);
}
