import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:elzo_wear/controllers/home_controller.dart';
import 'package:elzo_wear/core/app_routs.dart';
import 'package:elzo_wear/core/constants.dart';
import 'package:elzo_wear/models/user_model.dart';
import 'package:elzo_wear/view/widgets/Text_Filed_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  TextEditingController loginUsernameController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  bool remember = false;

  TextEditingController signUpUsernameController = TextEditingController();
  TextEditingController signUpEmailController = TextEditingController();
  TextEditingController signUpPasswordController = TextEditingController();
  TextEditingController signUpConfirmPasswordController =
      TextEditingController();
  TextEditingController recoveryEmailController = TextEditingController();

  bool loginButtonActive = false;
  bool signUpButtonActive = false;
  bool showLoginPassword = false;
  bool showSignUpPassword = false;
  bool recoveryPasswordButtonActive = false;

  TextEditingController profileNameController = TextEditingController();
  TextEditingController profileEmailController = TextEditingController();
  TextEditingController profilePhoneController = TextEditingController();
  TextEditingController profileAddressController = TextEditingController();

  File? imagePicked = File('-1');

  User? user;
  bool darkMode = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUser();
  }

  void validateTextField(String page) {
    switch (page) {
      case "login":
        {
          if (loginUsernameController.text.isNotEmpty &&
              (loginUsernameController.text).length >= 4 &&
              loginPasswordController.text.isNotEmpty &&
              (loginPasswordController.text).length >= 8) {
            loginButtonActive = true;
          } else {
            loginButtonActive = false;
          }
          update();
        }

      case "sign_up":
        {
          if (signUpUsernameController.text.isNotEmpty &&
              (signUpUsernameController.text).length >= 4 &&
              signUpEmailController.text.isEmail &&
              signUpPasswordController.text.isNotEmpty &&
              (signUpPasswordController.text).length >= 8 &&
              signUpConfirmPasswordController.text ==
                  signUpPasswordController.text) {
            signUpButtonActive = true;
          } else {
            signUpButtonActive = false;
          }
          update();
        }

      case "password_recovery":
        {
          if (recoveryEmailController.text.isEmail) {
            recoveryPasswordButtonActive = true;
          } else {
            recoveryPasswordButtonActive = false;
          }
          update();
        }

      default:
        {
          loginButtonActive = false;
          signUpButtonActive = false;
          recoveryPasswordButtonActive = false;
          update();
        }
    }
  }

  void signUp() async {
    if (signUpButtonActive) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var response =
          await http.post(Uri.parse('https://parseapi.back4app.com/users'),
              body: jsonEncode({
                'username': signUpUsernameController.text,
                'email': signUpEmailController.text,
                'password': signUpPasswordController.text,
              }),
              headers: Constants.header4);

      Map data = jsonDecode(response.body);
      if (response.statusCode == 201) {
        prefs.setString(Constants.userId, data['objectId']);
        prefs.setString(Constants.sessionToken, data['sessionToken']);
        prefs.setString(Constants.username, signUpUsernameController.text);
        profileEmailController.text = signUpEmailController.text;
        Get.toNamed(AppRouts.accountSetupScreen);
      } else {
        Get.snackbar("Error", data['error']);
      }
    }
  }

  void login() async {
    if (loginButtonActive) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var response = await http.get(
          Uri.parse(
              'https://parseapi.back4app.com/login?username=${loginUsernameController.text}&password=${loginPasswordController.text}'),
          headers: Constants.header2);
      Map data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        prefs.setString(Constants.userId, data['objectId']);
        prefs.setString(Constants.sessionToken, data['sessionToken']);
        prefs.setString(Constants.username, data['username']);
        if (remember) {
          prefs.setBool(Constants.remember, true);
        }
        Get.offAllNamed(AppRouts.homeScreen);
        getUserData();
      } else {
        Get.snackbar("Error", data['error']);
      }
    }
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

  forgetPassword() async {
    return Get.defaultDialog(
      title: 'Password Recovery',
      content: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Input your Email to send recovery link:',
            textAlign: TextAlign.left,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextField(
              controller: recoveryEmailController,
              hint: 'Email',
              prefixIcon: const Icon(Icons.email_outlined),
              onChanged: (value) {
                validateTextField('password_recovery');
              }),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
      textConfirm: 'Send',
      confirmTextColor: Colors.white,
      onConfirm: () {
        if (recoveryPasswordButtonActive) {
          sendRecoveryEmail(recoveryEmailController.text.trim());
        }
        else {
          Get.snackbar(
              'Password Recovery', 'Please Enter a correct Email address',
              backgroundColor: Colors.white);
        }
      },
      textCancel: 'Cancel',
      cancelTextColor: Colors.black,
      backgroundColor: Colors.white,
      buttonColor: recoveryPasswordButtonActive
          ? Colors.black
          : Colors.black.withOpacity(0.5),
      radius: 20,
    );
  }

  sendRecoveryEmail(String email) async {
    var response = await http.post(
      Uri.parse('https://parseapi.back4app.com/requestPasswordReset'),
      headers: Constants.header3,
      body: jsonEncode({'email': email}),
    );
    Map data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      Get.back();
      Get.snackbar(
          'Password Recovery', 'A recovery link had been sent to your Email',
          backgroundColor: Colors.white);
      recoveryEmailController.clear();
    } else {
      Get.snackbar("Error", data['error'], backgroundColor: Colors.white);
    }
  }

  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imagePicked = File(image.path);
      update();
    }
  }

  Future<String?> uploadImage() async {
    if (imagePicked!.path != '-1') {
      var response = await http.post(
        Uri.parse(
          'https://parseapi.back4app.com/parse/files/${imagePicked!.path.split('/').last}',
        ),
        headers: Constants.header5,
        body: imagePicked!.readAsBytesSync(),
      );
      if (response.statusCode == 201) {
        return jsonDecode(response.body)['url'];
      } else {
        Get.snackbar('Upload image result:', 'Upload failed');
        return null;
      }
    }
    return null;
  }

  void updateUser() async {
    String? imageAddress = await uploadImage();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String userId = prefs.getString(Constants.userId) ?? '-1';
    String sessionToken = prefs.getString(Constants.sessionToken) ?? '-1';
    String username = prefs.getString(Constants.username) ?? '-1';

    User newUser = User(
      username: username,
      name: profileNameController.text,
      email: profileEmailController.text,
      phone: profilePhoneController.text,
      address: profileAddressController.text,
      imageAddress: imageAddress ?? user!.imageAddress,
    );
    var response = await http.put(
      Uri.parse('https://parseapi.back4app.com/users/$userId'),
      headers: {
        'X-Parse-Application-Id': 'sUtPus4awhQjCRth6AIcJMfVtwKJWxSumfPlfBjC',
        'X-Parse-REST-API-Key': '0f5KLlTmw1dG51A2L2MjMtzHmdJU6lYQvhlUYfUU',
        'X-Parse-Session-Token': sessionToken,
        'Content-Type': 'application/json'
      },
      body: jsonEncode(newUser.toJson()),
    );
    Map data = (jsonDecode(response.body));

    if (response.statusCode == 200) {
      Get.offAllNamed(AppRouts.homeScreen);
    } else {
      Get.snackbar("Error", data['error'], backgroundColor: Colors.white);
    }
  }

  void updateUser2() async {
    String? imageAddress = await uploadImage();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String userId = prefs.getString(Constants.userId) ?? '-1';
    String sessionToken = prefs.getString(Constants.sessionToken) ?? '-1';
    String username = prefs.getString(Constants.username) ?? '-1';

    User newUser = User(
      username: username,
      name: profileNameController.text,
      email: profileEmailController.text,
      phone: profilePhoneController.text,
      address: profileAddressController.text,
      imageAddress: imageAddress ?? user!.imageAddress,
    );
    var response = await http.put(
      Uri.parse('https://parseapi.back4app.com/users/$userId'),
      headers: {
        'X-Parse-Application-Id': 'sUtPus4awhQjCRth6AIcJMfVtwKJWxSumfPlfBjC',
        'X-Parse-REST-API-Key': '0f5KLlTmw1dG51A2L2MjMtzHmdJU6lYQvhlUYfUU',
        'X-Parse-Session-Token': sessionToken,
        'Content-Type': 'application/json'
      },
      body: jsonEncode(newUser.toJson()),
    );
    Map data = (jsonDecode(response.body));

    if (response.statusCode == 200) {
      Get.back();
      getUser();
      HomeController().getUser();
      HomeController().update();
      update();
    } else {
      Get.snackbar("Error", data['error'], backgroundColor: Colors.white);
    }
  }

  void getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString(Constants.userId);
    if (userId != null) {
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
  }

  void changeTheme(bool value) {
    darkMode = value;
    update();
    if (darkMode) {
      Get.changeTheme(ThemeData.dark());
    } else {
      Get.changeTheme(ThemeData.light());
    }
  }

  logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.deleteAll();
    Get.toNamed(AppRouts.loginScreen,);
    Get.lazyPut(() => HomeController());
  }
}
