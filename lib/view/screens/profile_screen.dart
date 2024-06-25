import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:elzo_wear/controllers/user_controller.dart';
import 'package:elzo_wear/core/app_routs.dart';
import 'package:elzo_wear/view/widgets/Button_widget.dart';
import 'package:elzo_wear/view/widgets/base_widget.dart';

class ProfileScreen extends GetView<UserController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      init: UserController(),
      builder: (builder) {
        return Scaffold(
          appBar: AppBar(
            title: const Row(
              children: [
                Text('Profile'),
              ],
            ),
          ),
          body: BaseWidget(
            children: [
              Column(
                children: [
                  if (controller.user == null) ...[
                    const CircularProgressIndicator(),
                  ] else ...[
                    Column(
                      children: [
                        Container(
                          width: 160,
                          height: 160,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(80),
                          ),
                          child: CircleAvatar(
                            radius: 80,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(80),
                                child: controller.user!.imageAddress != null
                                    ? Image.network(
                                        controller.user!.imageAddress!,
                                        fit: BoxFit.fill,
                                      )
                                    : Image.asset('assets/Images/user.jpg')),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          controller.user!.name!,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          controller.user!.username!,
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.7),
                              fontSize: 14),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          controller.user!.phone!,
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.7),
                              fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                  const SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: Colors.black.withOpacity(0.1),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    onTap: () {
                      Get.toNamed(AppRouts.editProfileScreen);
                    },
                    title: const Text('Edite Profile'),
                    leading: const Icon(Iconsax.user),
                    trailing: const Icon(Iconsax.arrow_right, size: 30),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    onTap: () {},
                    title: const Text('Dark Mode'),
                    leading: const Icon(Iconsax.moon),
                    trailing: Switch(
                      hoverColor: Colors.transparent,
                      value: controller.darkMode,
                      onChanged: (value) {
                        controller.changeTheme(value);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    onTap: () {
                      Get.bottomSheet(
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Log Out ?',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
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
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: CustomButton(
                                      fontSize: 16,
                                      textColor: Colors.black,
                                      color: Colors.black.withOpacity(0.1),
                                      onTap: () {
                                        Get.back();
                                      },
                                      text: 'Cancel',
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: CustomButton(
                                      fontSize: 16,
                                      color: Colors.black,
                                      onTap: () {
                                        controller.logOut();
                                      },
                                      text: 'Yes, Log Out',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    title: const Text(
                      'Log Out',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    leading: const Icon(
                      Iconsax.logout,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
