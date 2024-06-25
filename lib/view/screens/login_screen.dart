import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elzo_wear/controllers/user_controller.dart';
import 'package:elzo_wear/view/widgets/Button_widget.dart';
import 'package:elzo_wear/view/widgets/Text_Filed_widget.dart';

class LoginScreen extends GetView<UserController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: GetBuilder<UserController>(
            builder: (builder) {
              return Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    'Login to your Account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  CustomTextField(
                    controller: controller.loginUsernameController,
                    hint: 'Username',
                    prefixIcon: const Icon(Icons.person),
                    onChanged: (value) {
                      controller.validateTextField('login');
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: controller.loginPasswordController,
                    obscureText: !controller.showLoginPassword,
                    hint: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: controller.showLoginPassword
                          ? Icon(
                              Icons.visibility,
                              color: Colors.black.withOpacity(0.5),
                            )
                          : Icon(
                              Icons.visibility_off,
                              color: Colors.black.withOpacity(0.5),
                            ),
                      onPressed: () {
                        controller.showLoginPassword =
                            !controller.showLoginPassword;
                        controller.update();
                      },
                    ),
                    onChanged: (value) {
                      controller.validateTextField('login');
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      Transform.scale(
                        scale: 1.1,
                        child: Checkbox(
                          side: const BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          value: controller.remember,
                          onChanged: (value) {
                            controller.remember = !controller.remember;
                            controller.update();
                          },
                        ),
                      ),
                      const Text(
                        'Remember Me',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          controller.forgetPassword();
                        },
                        child: const Text(
                          'Forgot your password?',
                          style: TextStyle(
                            color: Colors.indigo,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    color: controller.loginButtonActive
                        ? Colors.black
                        : Colors.black.withOpacity(0.5),
                    onTap: () {
                      if (controller.loginButtonActive) {
                        controller.login();
                      }
                    },
                    text: 'Sign in',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Divider(
                    color: Colors.black.withOpacity(0.2),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Don\'t have an Account? ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        TextSpan(
                          text: 'Sign up',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.toNamed('/sign_up');
                            },
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
