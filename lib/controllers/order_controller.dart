import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:elzo_wear/controllers/home_controller.dart';
import 'package:elzo_wear/core/constants.dart';
import 'package:elzo_wear/models/order_model.dart';
import 'package:elzo_wear/models/ordersList_model.dart';
import 'package:elzo_wear/models/product_model.dart';
import 'package:elzo_wear/view/widgets/Button_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderController extends GetxController {
  OrdersList ordersList = OrdersList();
  List<Map>? ongoingOrders = [];
  List<Map>? completedOrders = [];
  List<Map>? productsInOrder = [];
  Product? itemProduct = Product();
  bool showLoadingIcon = true;
  bool showDetailsLoading = true;
  List<Map>? listForRating = [];
  double totalRate = 0.0;
  double totalProductCount = 0;
  bool submitButtonActive = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getOrdersList();
  }

  void getOrdersList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? ordersListId = prefs.getString(Constants.ordersListId);
    if (ordersListId == null) {
      showLoadingIcon = false;
    } else {
      var response = await http.get(
          Uri.parse(
              'https://parseapi.back4app.com/classes/Orders_list/$ordersListId'),
          headers: Constants.header);
      if (response.statusCode == 200) {
        ordersList = OrdersList.fromJson(jsonDecode(response.body));
        for (var item in ordersList.orders!) {
          Order order = await getOrder(item.orderId!);
          if (order.status == 'Ongoing') {
            ongoingOrders!.add({'order': order, 'show_details': false});
          } else {
            completedOrders!.add({'order': order, 'show_details': false});
          }
          showLoadingIcon = false;
        }
      } else {
        showLoadingIcon = false;
      }
    }
    update();
  }

  Future<Order> getOrder(String orderId) async {
    var response = await http.get(
      Uri.parse('https://parseapi.back4app.com/classes/Orders/$orderId'),
      headers: Constants.header,
    );
    return Order.fromJson(jsonDecode(response.body));
  }

  Widget creatTabViewSections(Map order) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.black.withOpacity(0.05),
          ),
          child: Row(
            children: [
              Container(
                width: (Get.width - 40) / 7,
                height: (Get.width - 40) / 7,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: order['order'].status == 'Ongoing'
                        ? Colors.orange
                        : order['order'].status == 'Canceled'
                        ? Colors.red
                        : Colors.lightGreen),
                child: const Icon(
                  Iconsax.shopping_bag,
                  size: 30,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              'Order Number : ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              order['order'].objectId!,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              'Creat At : ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${order['order']
                                  .createdAt!
                                  .split('T')
                                  .first} (${order['order'].createdAt!.split(
                                  'T')[1].split(':')[0]}:${order['order']
                                  .createdAt!.split('T')[1].split(':')[1]})',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text(
                              'Status : ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              order['order'].status!,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: order['order'].status! == 'Ongoing'
                                    ? Colors.orange
                                    : order['order'].status! == 'Done'
                                    ? Colors.lightGreen
                                    : Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: (Get.width - 40) / 7,
                height: (Get.width - 40) / 7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: order['show_details']
                      ? (order['order'].status == 'Ongoing'
                      ? Colors.orange.withOpacity(0.2)
                      : order['order'].status == 'Done'
                      ? Colors.green.withOpacity(0.2)
                      : Colors.red.withOpacity(0.2))
                      : Colors.black.withOpacity(0.05),
                ),
                child: IconButton(
                  onPressed: () {
                    order['show_details'] = !order['show_details'];
                    if (order['show_details']) {
                      openOrderDetails(order);
                    } else {
                      closeOrderDetails();
                    }
                    update();
                  },
                  icon: order['show_details'] == false
                      ? const Icon(
                    Iconsax.arrow_right,
                  )
                      : const Icon(
                    Icons.arrow_drop_down,
                  ),
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  style: const ButtonStyle(
                      iconSize: MaterialStatePropertyAll(25)),
                ),
              ),
            ],
          ),
        ),
        showOrderDetails(order),
      ],
    );
  }

  void openOrderDetails(Map order) {
    showDetailsLoading = true;
    if (order['order'].status == 'Ongoing') {
      for (var item in ongoingOrders!) {
        item['show_details'] = false;
      }
      order['show_details'] = true;
    } else {
      for (var item in completedOrders!) {
        item['show_details'] = false;
      }
      order['show_details'] = true;
    }
    fillOrderProductsList(order);
    update();
  }

  void closeOrderDetails() {
    productsInOrder = [];
    listForRating = [];
    showDetailsLoading = true;
    update();
  }

  Future<void> fillOrderProductsList(Map order) async {
    productsInOrder = [];
    listForRating = [];
    totalProductCount = 0;
    Product? product;
    for (var item in order['order'].productsInOrder!) {
      product = await getProduct(item.productId!);
      productsInOrder!.add({'product': product, 'count': item.count});
      listForRating!.add(
        {
          'product': product,
          'rate': {'quality': 0.0, 'price': 0.0},
          'comment': null
        },
      );
      totalProductCount++;
    }
    showDetailsLoading = false;
    update();
  }

  Future<Product> getProduct(String productId) async {
    var response = await http.get(
      Uri.parse('https://parseapi.back4app.com/classes/Products/$productId'),
      headers: Constants.header,
    );
    return Product.fromJson(jsonDecode(response.body));
  }

  Widget showOrderDetails(Map order) {
    if (order['show_details']) {
      return Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: order['order'].status == 'Ongoing'
              ? Colors.orange.withOpacity(0.2)
              : order['order'].status == 'Done'
              ? Colors.green.withOpacity(0.2)
              : Colors.red.withOpacity(0.2),
        ),
        child: (showDetailsLoading)
            ? Center(
          child: Lottie.asset('assets/Animations/loading.json',
              width: 100, height: 50),
        )
            : Column(
          children: [
            ...productsInOrder!.map(
                  (Map item) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          item['product'].image!.url!,
                          width: (Get.width - 70) / 7,
                          height: (Get.width - 70) / 7,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item['product'].title!,
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
                              '\$ ${item['product'].price!.toStringAsFixed(1)}',
                              style: TextStyle(
                                fontSize: 12,
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
                        width: (Get.width - 70) / 7,
                        height: (Get.width - 70) / 7,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black.withOpacity(0.05)),
                        child: Center(
                          child: Text(
                            '${item['count']}',
                            style: const TextStyle(
                                fontSize: 12, color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Column(
              children: [
                Divider(
                  color: Colors.black.withOpacity(0.1),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.arrow_right,
                            size: 50,
                          ),
                          Text(
                            ' Total Price : \$ ${order['order'].total}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      order['order'].status != 'Canceled'
                          ? order['order'].status == 'Ongoing'
                          ? CustomButton(
                          width: 200,
                          fontSize: 12,
                          color: Colors.black,
                          onTap: () {},
                          icon: Iconsax.truck,
                          text: 'Go to delivery details')
                          : (order['order'].rate == '0.00')
                          ? CustomButton(
                        width: 200,
                        fontSize: 12,
                        color: Colors.black,
                        onTap: () {
                          rateOrder(order);
                        },
                        icon: Iconsax.star,
                        text: 'Rate this Order',
                      )
                          : Row(
                        children: [
                          const Text(
                            'Order\'s rate : ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(20),
                              color: (double.parse(order['order'].rate) >=
                                  1.00 &&
                                  double.parse(order['order'].rate) <
                                      2.00)
                                  ? Colors.red
                                  .withOpacity(0.3)
                                  : (double.parse(order['order'].rate) >=
                                  2.00 &&
                                  double.parse(order['order'].rate) <
                                      3.00)
                                  ? Colors.orange
                                  .withOpacity(0.3)
                                  : (double.parse(order['order'].rate) >=
                                  3.00 &&
                                  double.parse(order['order'].rate) <
                                      4.00)
                                  ? Colors.green
                                  .withOpacity(
                                  0.3)
                                  : Colors.green
                                  .withOpacity(
                                  0.6),
                            ),
                            child: Center(
                              child: Text(
                                '${double.parse(order['order'].rate)}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight:
                                  FontWeight.bold,
                                  color: (double.parse(
                                      order['order']
                                          .rate) >=
                                      1.00 &&
                                      double.parse(
                                          order['order']
                                              .rate) <
                                          2.00)
                                      ? Colors.red
                                      : (double.parse(order['order'].rate) >=
                                      2.00 &&
                                      double.parse(order['order'].rate) <
                                          3.00)
                                      ? Colors.orange
                                      : (double.parse(order['order'].rate) >=
                                      3.00 &&
                                      double.parse(order['order'].rate) <
                                          4.00)
                                      ? Colors
                                      .green[500]
                                      : Colors.green[800],
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                          : const SizedBox(
                        width: 0,
                        height: 0,
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      );
    } else {
      return Container(height: 0);
    }
  }

  void rateOrder(Map order) {
    totalRate = 0;
    Get.bottomSheet(
      SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Order Reiview',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
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
              Column(
                children: [
                  ...listForRating!.map(
                        (Map item) {
                      double rate = 0;
                      double preRate = 0;
                      TextEditingController commentController =
                      TextEditingController();
                      return Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        item['product'].image!.url!,
                                        width: 100,
                                        height: 100,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '\$ ${item['product'].price!
                                          .toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        item['product'].title!,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Quality :',
                                            style: TextStyle(
                                                fontWeight:
                                                FontWeight.bold,
                                                fontSize: 10),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          RatingBar.builder(
                                            initialRating: 0,
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemPadding:
                                            const EdgeInsets
                                                .symmetric(
                                                horizontal: 4.0),
                                            itemBuilder: (context, _) =>
                                            const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            onRatingUpdate: (rating) {
                                              item['rate']['quality'] =
                                                  rating;
                                              rate = (item['rate']
                                              ['quality'] +
                                                  item['rate']
                                                  ['price']) /
                                                  2;
                                              totalRate +=
                                                  rate - preRate;
                                              preRate = rate;
                                              update();
                                              validateSubmitButtonActive();
                                            },
                                            itemSize: 25,
                                            maxRating: 5,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Price :',
                                            style: TextStyle(
                                                fontWeight:
                                                FontWeight.bold,
                                                fontSize: 10),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          RatingBar.builder(
                                            initialRating: 0,
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemPadding:
                                            const EdgeInsets
                                                .symmetric(
                                                horizontal: 4.0),
                                            itemBuilder: (context, _) =>
                                            const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            onRatingUpdate: (rating) {
                                              item['rate']['price'] =
                                                  rating;
                                              rate = (item['rate']
                                              ['quality'] +
                                                  item['rate']
                                                  ['price']) /
                                                  2;
                                              totalRate +=
                                                  rate - preRate;
                                              preRate = rate;
                                              update();
                                              validateSubmitButtonActive();
                                            },
                                            itemSize: 25,
                                            maxRating: 5,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          const Spacer(),
                                          GetBuilder<OrderController>(
                                            builder: (builder) {
                                              return Container(
                                                alignment: Alignment.center,
                                                width: 100,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(20),
                                                  color: (rate == 0)
                                                      ? Colors.black
                                                      .withOpacity(0.1)
                                                      : (rate >= 1 && rate < 2)
                                                      ? Colors.red
                                                      .withOpacity(0.3)
                                                      : (rate >= 2 &&
                                                      rate < 3)
                                                      ? Colors.orange
                                                      .withOpacity(
                                                      0.3)
                                                      : (rate >= 3 &&
                                                      rate < 4)
                                                      ? Colors.green
                                                      .withOpacity(
                                                      0.3)
                                                      : Colors.green
                                                      .withOpacity(
                                                      0.6),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    rate.toStringAsFixed(2),
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      color: (rate == 0)
                                                          ? Colors.black
                                                          .withOpacity(0.5)
                                                          : (rate >= 1 &&
                                                          rate < 2)
                                                          ? Colors.red
                                                          : (rate >= 2 &&
                                                          rate < 3)
                                                          ? Colors
                                                          .orange
                                                          : (rate >= 3 &&
                                                          rate <
                                                              4)
                                                          ? Colors.green[
                                                      500]
                                                          : Colors.green[
                                                      800],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Divider(),
                            const SizedBox(
                              height: 5,
                            ),
                            TextField(
                              onChanged: (value) {
                                item['comment'] = commentController.text;
                                update();
                                validateSubmitButtonActive();
                              },
                              controller: commentController,
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.comment_outlined),
                                hintText:
                                'Leave a comment for this product ...',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(
                                        width:
                                        2)), // حاشیه‌نگاری برای جعبه ورودی
                              ),
                            )
                          ],
                        ),
                      );
                    },
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
              GetBuilder<OrderController>(
                  builder: (builder) {
                return Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Order\'s Total Rate :',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RatingBar.builder(
                              ignoreGestures: true,
                              initialRating: totalRate / totalProductCount,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                              const EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) =>
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemSize: 30,
                              maxRating: 5,
                              onRatingUpdate: (double value) {},
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(children: [
                      const Spacer(),
                      Container(
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: (totalRate / totalProductCount == 0)
                              ? Colors.black.withOpacity(0.1)
                              : (totalRate / totalProductCount >= 1 &&
                              totalRate / totalProductCount < 2)
                              ? Colors.red.withOpacity(0.3)
                              : (totalRate / totalProductCount >=
                              2 &&
                              totalRate / totalProductCount <
                                  3)
                              ? Colors.orange.withOpacity(0.3)
                              : (totalRate / totalProductCount >=
                              3 &&
                              totalRate /
                                  totalProductCount <
                                  4)
                              ? Colors.green.withOpacity(0.3)
                              : Colors.green.withOpacity(0.6),
                        ),
                        child: Center(
                          child: Text(
                            (totalRate / totalProductCount)
                                .toStringAsFixed(2),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: (totalRate / totalProductCount == 0)
                                  ? Colors.black.withOpacity(0.5)
                                  : (totalRate / totalProductCount >=
                                  1 &&
                                  totalRate / totalProductCount <
                                      2)
                                  ? Colors.red
                                  : (totalRate / totalProductCount >=
                                  2 &&
                                  totalRate /
                                      totalProductCount <
                                      3)
                                  ? Colors.orange
                                  : (totalRate / totalProductCount >=
                                  3 &&
                                  totalRate /
                                      totalProductCount <
                                      4)
                                  ? Colors.green[500]
                                  : Colors.green[800],
                            ),
                          ),
                        ),
                      ),
                    ],)
                  ],
                );
              }),
              const SizedBox(
                height: 5,
              ),
              Divider(
                color: Colors.black.withOpacity(0.1),
              ),
              const SizedBox(
                height: 5,
              ),
              GetBuilder<OrderController>(builder: (builder) {
                return CustomButton(
                  color: (submitButtonActive)
                      ? Colors.black
                      : Colors.black.withOpacity(0.5),
                  onTap: () {
                    if (submitButtonActive) {
                      submitRating(order);
                    }
                  },
                  text: 'Submit',
                  fontSize: 16,
                  icon: Icons.save_alt,
                );
              },),
            ],
          ),
        ),
      ),
    );
  }

  void validateSubmitButtonActive() {
    for (var item in listForRating!) {
      if (item['rate']['quality'] != 0 &&
          item['rate']['price'] != 0 &&
          item['comment'] != '' &&
          item['comment'] != null) {
        submitButtonActive = true;
        update();
      } else {
        submitButtonActive = false;
        update();
      }
    }
  }

  void submitRating(Map order) async {
    bool result = true;
    for (var item in listForRating!) {
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
        stock: product.stock,
        rate: product.rate!
          ..add(
            Rate(
              quality: item['rate']['quality'],
              price: item['rate']['price'],
            ),
          ),
        buyCounter: product.buyCounter,
        comments: product.comments!
          ..add(
            Comments(
              user: HomeController().user,
              comment: item['comment'],
            ),
          ),
      );

      var response = await http.put(
        Uri.parse('https://parseapi.back4app.com/classes/Products/$productId'),
        headers: Constants.header3,
        body: jsonEncode(newProduct.toJson()),
      );
      if (response.statusCode != 200) {
        result = false;
        Get.snackbar("Error", jsonDecode(response.body)['error']);
      }
    }
    if (result) {
      Order newOrder = Order(
        objectId: order['order'].objectId,
        userId: order['order'].userId,
        status: order['order'].status,
        total: order['order'].total,
        productsInOrder: order['order'].productsInOrder,
        rate: (totalRate / totalProductCount).toStringAsFixed(2),
      );
      var response = await http.put(
        Uri.parse(
            'https://parseapi.back4app.com/classes/Orders/${order['order']
                .objectId}'),
        headers: Constants.header3,
        body: jsonEncode(newOrder.toJson()),
      );
      if (response.statusCode == 200) {
        Get.defaultDialog(
          title: '',
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
                'Rating Successful',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Thanks for your rating',
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
                  Get.back();
                  Get.back();
                  order['show_details'] = false;
                  update();
                },
                text: 'Get back',
                fontSize: 16,
              ),
            ],
          ),
        );
      } else {
        Get.snackbar("Error", jsonDecode(response.body)['error']);
      }
    }
  }
}
