import 'package:get/get.dart';
import 'package:elzo_wear/core/app_routs.dart';
import 'package:elzo_wear/core/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    checkUser();
  }

  checkUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool existUser = prefs.getBool(Constants.remember) ?? false;

    Future.delayed(
      const Duration(seconds: 3),
      () {
        if (existUser) {
          Get.offNamed(AppRouts.homeScreen);
        } else {
          Get.offNamed(AppRouts.loginScreen);
        }
      },
    );
  }
}
