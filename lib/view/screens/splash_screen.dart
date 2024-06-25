import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elzo_wear/controllers/splash_controller.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 30,),
              const Text(
                'Welcome to',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
              ),
              const SizedBox(
                height: 100,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Center(
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(40)),
                          child: Container(
                            color: Colors.black,
                            height: 200,
                            width: 200,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Center(
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(40)),
                            child: Lottie.asset(
                              'assets/Animations/Smile2.json',
                              width: 150,
                              height: 150,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Smile',
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 60),
                      ),
                      Text(
                        'Shop',
                        style: TextStyle(fontSize: 30, color: Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Container(
                alignment: Alignment.bottomCenter,
                child: const Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Shopping With Smile ...',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
