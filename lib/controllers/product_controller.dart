import 'dart:convert';
import 'package:get/get.dart';
import 'package:elzo_wear/core/constants.dart';
import 'package:elzo_wear/models/cart_model.dart';
import 'package:elzo_wear/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProductController extends GetxController {
  Product product = Get.arguments;
  int productCounter = 1;
  int productSum = 0;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getSum();
  }

  void counterPlus() {
    if (productCounter < product.stock!) {
      productCounter++;
    }
    update();
  }

  void counterReduce() {
    if (productCounter > 1) {
      productCounter--;
    }
    update();
  }

  void getSum() {
    productSum = productCounter * product.price!;
    update();
  }

  void addToCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cartId = prefs.getString(Constants.cartId);
    String userId = prefs.getString(Constants.userId) ?? '-1';
    if (cartId == null) {
      creatNewCart(userId);
    } else {
      updateCart(cartId, userId);
    }
  }

  void creatNewCart(String userId) async {
    Cart cart = Cart(
      userId: userId,
      productsInCart: [
        ProductsInCart(
          count: productCounter,
          productId: product.objectId,
        ),
      ],
      total: productSum,
    );
    var response = await http.post(
      Uri.parse('https://parseapi.back4app.com/classes/cart'),
      headers: Constants.header3,
      body: jsonEncode(cart.toJson()),
    );
    Map data = jsonDecode(response.body);
    if (response.statusCode == 201) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(Constants.cartId, data['objectId']);
      Get.snackbar('Creat New Cart', '${product.title} added to Cart');
    } else {
      Get.snackbar("Error", data['error']);
    }
  }

  void updateCart(String cartId, String userId) async {
    var response = await http.get(
      Uri.parse('https://parseapi.back4app.com/classes/cart/$cartId'),
      headers:Constants.header3,
    );
    Cart oldCart = Cart.fromJson(jsonDecode(response.body));
    Cart cart = Cart(
      userId: userId,
      total: oldCart.total! + productSum,
      productsInCart: oldCart.productsInCart!
        ..add(
          ProductsInCart(
            productId: product.objectId,
            count: productCounter,
          ),
        ),
    );
    var updateResponse = await http.put(
      Uri.parse('https://parseapi.back4app.com/classes/cart/$cartId'),
      headers: Constants.header3,
      body: jsonEncode(cart.toJson()),
    );

    Map data = jsonDecode(updateResponse.body);

    if (updateResponse.statusCode == 200) {
      Get.snackbar('Update Cart', '${product.title} added to Cart');
    } else {
      Get.snackbar("Error", data['error']);
    }
  }
}
