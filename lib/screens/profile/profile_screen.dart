import 'package:aplikasi_nagaricare/screens/profile/edit_profile_screen.dart';
import 'package:aplikasi_nagaricare/constants/app_colors.dart';
import 'package:aplikasi_nagaricare/repository/authentication_repository/authentication_repository.dart';
import 'package:aplikasi_nagaricare/screens/auth/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:aplikasi_nagaricare/controllers/profile_controller.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    profileController
        .fetchUserProfile(); // Automatically fetch user data on screen load
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(
          child: Text(
            'My Profile',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: <Widget>[
                Container(
                  height: 100,
                  width: 100,
                  margin: const EdgeInsets.only(top: 10 * 3),
                  child: Stack(
                    children: <Widget>[
                      Obx(() {
                        return profileController.profilePicture.value.isNotEmpty
                            ? CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(
                                    profileController.profilePicture.value),
                              )
                            : const CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.grey,
                                child: Icon(
                                  Icons.person,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              );
                      }),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Obx(() {
                      return Text(
                        profileController.name.value.isNotEmpty
                            ? profileController.name.value
                            : "No Name Provided",
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      );
                    }),
                    const SizedBox(height: 5),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(const EditProfileScreen());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accentColor,
                          side: BorderSide.none,
                          shape: const StadiumBorder(),
                        ),
                        child: const Text(
                          'Edit Profile',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Divider(),
                    const SizedBox(height: 10),
                    Obx(() {
                      return ListTile(
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: AppColors.secondaryColor.withOpacity(0.2),
                          ),
                          child: const Icon(
                            LineAwesomeIcons.envelope,
                            color: AppColors.accentColor,
                          ),
                        ),
                        title: const Text('Your Email'),
                        subtitle: Text(
                          profileController.email.value.isNotEmpty
                              ? profileController.email.value
                              : "No email provided",
                        ),
                      );
                    }),
                    Obx(() {
                      return ListTile(
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: AppColors.secondaryColor.withOpacity(0.2),
                          ),
                          child: const Icon(
                            LineAwesomeIcons.phone_solid,
                            color: AppColors.accentColor,
                          ),
                        ),
                        title: const Text('Your Phone'),
                        subtitle: Text(
                          profileController.phone.value.isNotEmpty
                              ? profileController.phone.value
                              : "No phone provided",
                        ),
                      );
                    }),
                    const SizedBox(height: 10),
                    const Divider(),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: AppColors.backgroundColor,
                                title: const Text("Konfirmasi Logout"),
                                content: const Text(
                                    "Apakah anda yakin ingin logout?"),
                                actions: [
                                  TextButton(
                                    child: const Text(
                                      "Tidak",
                                      style: TextStyle(
                                          color: AppColors.alertColor),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text(
                                      "Iya",
                                      style: TextStyle(
                                          color: AppColors.accentColor),
                                    ),
                                    onPressed: () {
                                      AuthenticationRepository.instance
                                          .logout()
                                          .then(
                                        (value) {
                                          Navigator.of(context).pop();
                                          Get.offAll(
                                              () => const WelcomeScreen());
                                        },
                                      );
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.alertColor,
                          side: BorderSide.none,
                          shape: const StadiumBorder(),
                        ),
                        child: const Text(
                          'LOGOUT',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
