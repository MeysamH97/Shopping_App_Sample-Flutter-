import 'package:get/get.dart';
import 'package:elzo_wear/controllers/bindings/cart_binding.dart';
import 'package:elzo_wear/controllers/bindings/category_binding.dart';
import 'package:elzo_wear/controllers/bindings/checkout_binding.dart';
import 'package:elzo_wear/controllers/bindings/home_bindings.dart';
import 'package:elzo_wear/controllers/bindings/order_binding.dart';
import 'package:elzo_wear/controllers/bindings/payment_binding.dart';
import 'package:elzo_wear/controllers/bindings/product_binding.dart';
import 'package:elzo_wear/controllers/bindings/shipping_binding.dart';
import 'package:elzo_wear/controllers/bindings/user_bindings.dart';
import 'package:elzo_wear/view/screens/login_screen.dart';
import 'package:elzo_wear/view/screens/account_setup_screen.dart';
import 'package:elzo_wear/view/screens/cart_screen.dart';
import 'package:elzo_wear/view/screens/category_screen.dart';
import 'package:elzo_wear/view/screens/checkout_screen.dart';
import 'package:elzo_wear/view/screens/edit_profile_screen.dart';
import 'package:elzo_wear/view/screens/main_screen.dart';
import 'package:elzo_wear/view/screens/order_screen.dart';
import 'package:elzo_wear/view/screens/payment_screen.dart';
import 'package:elzo_wear/view/screens/product_screen.dart';
import 'package:elzo_wear/view/screens/profile_screen.dart';
import 'package:elzo_wear/view/screens/shipping_screen.dart';
import 'package:elzo_wear/view/screens/sign_up_screen.dart';
import 'package:elzo_wear/view/screens/splash_screen.dart';

class AppRouts {
  static const String root = '/';
  static const String homeScreen = '/home';
  static const String loginScreen = '/login';
  static const String signUpScreen = '/sign_up';
  static const String accountSetupScreen = '/account_setup';
  static const String categoryScreen = '/category';
  static const String productScreen = '/product';
  static const String cartScreen = '/cart';
  static const String checkoutScreen = '/checkout';
  static const String paymentScreen = '/payment';
  static const String shippingScreen = '/shipping';
  static const String orderScreen = '/order';
  static const String profileScreen = '/profile';
  static const String editProfileScreen = '/edit_profile';

  static List<GetPage> pages = [

    GetPage(
      name: root,
      page: () => const SplashScreen(),
    ),


    GetPage(
      name: homeScreen,
      page: () => const MainScreen(),
      binding: HomeBinding(),
    ),

    GetPage(
      name: loginScreen,
      page: () => const LoginScreen(),
      binding: UserBinding(),
    ),

    GetPage(
      name: signUpScreen,
      page: () => const SignUpScreen(),
      binding: UserBinding(),
    ),

    GetPage(
      name: accountSetupScreen,
      page: () => const AccountSetupScreen(),
      binding: UserBinding(),
    ),

    GetPage(
      name: categoryScreen,
      page: () => const CategoryScreen(),
      binding: CategoryBinding(),
    ),

    GetPage(
      name: productScreen,
      page: () => const ProductScreen(),
      binding: ProductBinding(),
    ),

    GetPage(
      name: cartScreen,
      page: () => const CartScreen(),
      binding: CartBinding(),
    ),

    GetPage(
      name: checkoutScreen,
      page: () => const CheckoutScreen(),
      binding: CheckoutBinding(),
    ),

    GetPage(
      name: shippingScreen,
      page: () =>  const ShippingScreen(),
      binding: ShippingBinding(),
    ),

    GetPage(
      name: paymentScreen,
      page: () =>  const PaymentScreen(),
      binding: PaymentBinding(),
    ),

    GetPage(
      name: orderScreen,
      page: () =>  const OrderScreen(),
      binding: OrderBinding(),
    ),

    GetPage(
      name: profileScreen,
      page: () =>  const ProfileScreen(),
      binding: UserBinding(),
    ),

    GetPage(
      name: editProfileScreen,
      page: () =>  const EditProfileScreen(),
      binding: UserBinding(),
    ),
  ];
}
