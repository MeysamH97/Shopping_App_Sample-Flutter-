import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elzo_wear/core/app_routs.dart';
import 'controllers/bindings/splash_bindings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: SplashBinding(),
      initialRoute: AppRouts.root,
      getPages: AppRouts.pages,
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.leftToRightWithFade,
    );
  }
}
