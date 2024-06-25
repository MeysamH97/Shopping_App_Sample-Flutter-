import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elzo_wear/controllers/user_controller.dart';
import 'package:elzo_wear/view/widgets/Button_widget.dart';
import 'package:elzo_wear/view/widgets/Text_Filed_widget.dart';

class AccountSetupScreen extends GetView<UserController> {
  const AccountSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Complete Profile',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: GetBuilder<UserController>(
          builder: (builder) {
            return Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(60),border: Border.all(width: 2)),
                      child: CircleAvatar(
                        radius: 60,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: controller.imagePicked!.path == '-1'
                              ? Image.asset('assets/Images/user.jpg')
                              : Image.file(
                                  controller.imagePicked!,
                                  fit: BoxFit.fill,
                                ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: GestureDetector(
                        onTap: () {
                          controller.pickImage();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.all(
                              Radius.circular(7),
                            ),
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                CustomTextField(
                  controller: controller.profileNameController,
                  hint: 'Full Name',
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  controller: controller.profileEmailController,
                  hint: 'Email',
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  controller: controller.profilePhoneController,
                  hint: 'Phone Number',
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  controller: controller.profileAddressController,
                  hint: 'Address',
                ),
                const SizedBox(
                  height: 50,
                ),
                CustomButton(
                  color: Colors.black,
                  onTap: () {
                    controller.updateUser();
                  },
                  text: 'Continue',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
