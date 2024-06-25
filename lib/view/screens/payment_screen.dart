import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elzo_wear/controllers/payment_controller.dart';

class PaymentScreen extends GetView<PaymentController> {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Iconsax.card,
              color: Colors.black,
            ),
            SizedBox(width: 20,),
            Text(
              'Payment Form',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.blue, Colors.lightBlueAccent
              ])),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue, Colors.lightBlueAccent
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              elevation: 10.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Payment Details',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      children: [
                        Text(
                          'Total Amount:',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[900],
                          ),
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          '\$ ${controller.order.total}',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.blue[900],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Divider(color: Colors.blue[900]),
                    const SizedBox(height: 10.0),
                    Text(
                      'Card Information:',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900],
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      'Card Number : ',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900],
                      ),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 80,
                          alignment: Alignment.center,
                          child: TextFormField(
                            controller: controller.cardNumber1,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              hintText: 'XXXX',
                            ),
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            maxLength: 4,
                            validator: (value) {
                              if (value == null) {
                                return 'Please enter your card number';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text('-'),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 80,
                          alignment: Alignment.center,
                          child: TextFormField(
                            controller: controller.cardNumber2,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              hintText: 'XXXX',
                            ),
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            maxLength: 4,
                            validator: (value) {
                              if (value == null) {
                                return 'Please enter your card number';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text('-'),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 80,
                          alignment: Alignment.center,
                          child: TextFormField(
                            controller: controller.cardNumber3,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              hintText: 'XXXX',
                            ),
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            maxLength: 4,
                            validator: (value) {
                              if (value == null) {
                                return 'Please enter your card number';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text('-'),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 80,
                          alignment: Alignment.center,
                          child: TextFormField(
                            controller: controller.cardNumber4,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              hintText: 'XXXX',
                            ),
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            maxLength: 4,
                            validator: (value) {
                              if (value == null) {
                                return 'Please enter your card number';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30.0),
                    Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              'Expiration Date : ',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[900],
                              ),
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 80,
                                  alignment: Alignment.center,
                                  child: TextFormField(
                                    controller: controller.expireYear,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                      ),
                                      hintText: 'Year',
                                    ),
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    maxLength: 2,
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Please enter your card number';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text('/'),
                                const SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  width: 80,
                                  alignment: Alignment.center,
                                  child: TextFormField(
                                    controller: controller.expireMonth,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                      ),
                                      hintText: 'Month',
                                    ),
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    maxLength: 2,
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Please enter your card number';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          children: [
                            Text(
                              'CVV2 : ',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[900],
                              ),
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 80,
                                  alignment: Alignment.center,
                                  child: TextFormField(
                                    controller: controller.cvv2,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                      ),
                                      hintText: 'Cvv2',
                                    ),
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    maxLength: 4,
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Please enter your card number';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Row(children: [
                      Column(
                        children: [
                          Text(
                            'Dynamic password : ',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[900],
                            ),
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                width: 200,
                                alignment: Alignment.center,
                                child: TextFormField(
                                  controller: controller.cvv2,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                    ),
                                    hintText: 'Cvv2',
                                  ),
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  maxLength: 4,
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Please enter your card number';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],),
                    ElevatedButton(
                      onPressed: () {
                          _showSuccessDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(15.0), backgroundColor: Colors.blue[900],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_forward),
                          SizedBox(width: 10.0),
                          Text(
                            'Pay Now',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:
              const Icon(Icons.check_circle, color: Colors.green, size: 80.0),
          content: const Text('Payment Successful!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Get.back();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
