import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elzo_wear/controllers/user_controller.dart';
import 'package:elzo_wear/view/widgets/Button_widget.dart';
import 'package:elzo_wear/view/widgets/Text_Filed_widget.dart';

class SignUpScreen extends GetView<UserController> {
  const SignUpScreen({super.key});

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
                    'Creat your new Account',
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
                    controller: controller.signUpUsernameController,
                    hint: 'Username',
                    prefixIcon: const Icon(Icons.person),
                    onChanged: (value) {
                      controller.validateTextField('sign_up');
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: controller.signUpEmailController,
                    hint: 'Email',
                    prefixIcon: const Icon(Icons.email),
                    onChanged: (value) {
                      controller.validateTextField('sign_up');
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: controller.signUpPasswordController,
                    obscureText: !controller.showSignUpPassword,
                    hint: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: controller.showSignUpPassword
                          ? Icon(
                              Icons.visibility,
                              color: Colors.black.withOpacity(0.5),
                            )
                          : Icon(
                              Icons.visibility_off,
                              color: Colors.black.withOpacity(0.5),
                            ),
                      onPressed: () {
                        controller.showSignUpPassword =
                            !controller.showSignUpPassword;
                        controller.update();
                      },
                    ),
                    onChanged: (value) {
                      controller.validateTextField('sign_up');
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: controller.signUpConfirmPasswordController,
                    obscureText: !controller.showSignUpPassword,
                    hint: 'Confirm your Password',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: controller.showSignUpPassword
                          ? Icon(
                              Icons.visibility,
                              color: Colors.black.withOpacity(0.5),
                            )
                          : Icon(
                              Icons.visibility_off,
                              color: Colors.black.withOpacity(0.5),
                            ),
                      onPressed: () {
                        controller.showSignUpPassword =
                            !controller.showSignUpPassword;
                        controller.update();
                      },
                    ),
                    onChanged: (value) {
                      controller.validateTextField('sign_up');
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    color: controller.signUpButtonActive
                        ? Colors.black
                        : Colors.black.withOpacity(0.5),
                    onTap: () {
                      if (controller.signUpButtonActive) {
                        controller.signUp();
                      }
                    },
                    text: 'Sign up',
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
                          text: 'Already have an Account? ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                          ),
                        ),
                        TextSpan(
                          text: 'Sign in',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.back();
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
