import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elzo_wear/controllers/user_controller.dart';
import 'package:elzo_wear/view/widgets/Button_widget.dart';
import 'package:elzo_wear/view/widgets/Text_Filed_widget.dart';
import 'package:elzo_wear/view/widgets/base_widget.dart';

class EditProfileScreen extends GetView<UserController> {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Iconsax.arrow_left),
        ),
      ),
      body: BaseWidget(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: GetBuilder<UserController>(
              builder: (builder) {
                controller.profileNameController.text =
                    controller.user!.name ?? '';
                controller.profileEmailController.text =
                    controller.user!.email ?? '';
                controller.profilePhoneController.text =
                    controller.user!.phone ?? '';
                controller.profileAddressController.text =
                    controller.user!.address ?? '';
                return Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(60),
                          ),
                          child: CircleAvatar(
                            radius: 60,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: controller.user!.imageAddress != null
                                  ? Image.network(
                                      controller.user!.imageAddress!,
                                      fit: BoxFit.fill,
                                    )
                                  : controller.imagePicked!.path == '-1'
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
                          child: Container(
                            width: 25,
                            height: 25,
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.all(
                                Radius.circular(7),
                              ),
                            ),
                            child: IconButton(
                              padding: const EdgeInsets.all(0),
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 18,
                              ),
                              onPressed: () {
                                controller.pickImage();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Divider(
                      color: Colors.black.withOpacity(0.1),
                    ),
                    const SizedBox(
                      height: 10,
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
                        controller.updateUser2();
                        Future.delayed(
                          const Duration(seconds: 1),
                          () {
                            controller.getUser();
                          },
                        );
                      },
                      text: 'Save Changes',
                      fontSize: 16,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
