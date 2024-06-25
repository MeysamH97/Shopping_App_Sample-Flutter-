import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:elzo_wear/core/constants.dart';
import 'package:elzo_wear/models/cart_model.dart';
import 'package:elzo_wear/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartController extends GetxController {
  Cart cart = Cart();
  List<Map>? products = [];
  int productsCounter = 0;
  bool showLoadingIcon = true;
  int totalPrice = 0;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Future.delayed(
      const Duration(seconds: 1),
      () {
        getCart();
      },
    );
  }

  void getCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cartId = prefs.getString(Constants.cartId);
    if (cartId == null) {
      showLoadingIcon = false;
      update();
    } else {
      var response = await http.get(
          Uri.parse('https://parseapi.back4app.com/classes/cart/$cartId'),
          headers: Constants.header);
      if (response.statusCode == 200) {
        cart = Cart.fromJson(jsonDecode(response.body));
        productsCounter = cart.productsInCart!.length;
        for (var item in cart.productsInCart!) {
          products!.add(
            {
              'count': item.count,
              'product': await getProduct(item.productId!),
            },
          );
          showLoadingIcon = false;
        }
      } else {
        showLoadingIcon = false;
      }
    }
    update();
  }

  Future<Product> getProduct(String productId) async {
    var response = await http.get(
      Uri.parse('https://parseapi.back4app.com/classes/Products/$productId'),
      headers: Constants.header,
    );
    return Product.fromJson(jsonDecode(response.body));
  }

  getTotal() async {
    int sum = 0;
    for (var item in products!) {
      Product product = item['product'];
      int count = item['count'];
      sum += count * product.price!;
    }
    cart.total = sum;
    update();
  }

  updateCart(String productId, int count) async {
    getTotal();
    for (int i = 0; i < cart.productsInCart!.length; i++) {
      if (cart.productsInCart![i].productId == productId) {
        cart.productsInCart![i] = ProductsInCart(
          count: count,
          productId: productId,
        );
      }
    }
    var response = await http.put(
      Uri.parse('https://parseapi.back4app.com/classes/cart/${cart.objectId}'),
      headers: Constants.header3,
      body: jsonEncode(cart.toJson()),
    );
    if (response.statusCode != 200) {
      Get.snackbar("Error", jsonDecode(response.body)['error'],
          backgroundColor: Colors.white);
    }
  }

  void removeFromCart(String productId) async {
    products!.removeWhere(
        (element) => (element['product'] as Product).objectId == productId);
    getTotal();
    cart.productsInCart!
        .removeWhere((element) => element.productId == productId);
    var response = await http.put(
      Uri.parse('https://parseapi.back4app.com/classes/cart/${cart.objectId}'),
      headers: Constants.header3,
      body: jsonEncode(cart.toJson()),
    );
    if (response.statusCode != 200) {
      Get.snackbar("Error", jsonDecode(response.body)['error'],
          backgroundColor: Colors.white);
    }
    if (cart.total == 0) {
      SharedPreferences prefs =await SharedPreferences.getInstance();
      String? cartId = prefs.getString(Constants.cartId);
      var response = await http.delete(
        Uri.parse(
            'https://parseapi.back4app.com/classes/cart/$cartId'),
        headers: Constants.header,
      );
      prefs.remove(Constants.cartId);
      showLoadingIcon = false ;
      if (response.statusCode != 200) {
        Get.snackbar("Error", jsonDecode(response.body)['error'],
            backgroundColor: Colors.white);
      }
    }
    update();
  }
}
