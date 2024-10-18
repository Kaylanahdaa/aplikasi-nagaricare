import 'package:aplikasi_nagaricare/constants/app_colors.dart';
import 'package:aplikasi_nagaricare/repository/authentication_repository/authentication_repository.dart';
import 'package:aplikasi_nagaricare/screens/auth/welcome/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../controllers/profile_controller.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'My Profile',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    'https://images.pexels.com/photos/1819650/pexels-photo-1819650.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 10),
              FutureBuilder<void>(
                future: profileController
                    .fetchUserProfile(), // Call fetchUserProfile
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Obx(() {
                              return Text(
                                profileController.displayName.value.isNotEmpty
                                    ? profileController.displayName.value
                                    : "No Name Provided",
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              );
                            }),
                            const SizedBox(height: 5),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: 200,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Add functionality to edit profile
                                },
                                child: const Text(
                                  'Edit Profile',
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  side: BorderSide.none,
                                  shape: StadiumBorder(),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            const Divider(),
                            const SizedBox(height: 10),
                            // Profile picture and other UI elements
                            Obx(() {
                              return ListTile(
                                leading: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: AppColors.secondaryColor
                                        .withOpacity(0.1),
                                  ),
                                  child: const Icon(
                                    LineAwesomeIcons.envelope,
                                    color: AppColors.secondaryColor,
                                  ),
                                ),
                                title: Text('Your Email'),
                                subtitle: Text(
                                    profileController.email.value.isNotEmpty
                                        ? profileController.email.value
                                        : "No email provided"),
                              );
                            }),
                            Obx(() {
                              return ListTile(
                                leading: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: AppColors.secondaryColor
                                        .withOpacity(0.1),
                                  ),
                                  child: const Icon(
                                    LineAwesomeIcons.phone_solid,
                                    color: AppColors.secondaryColor,
                                  ),
                                ),
                                title: Text('Your Phone'),
                                subtitle: Text(
                                    profileController.phone.value.isNotEmpty
                                        ? profileController.phone.value
                                        : "No phone provided"),
                              );
                            }),
                            const Divider(),
                            SizedBox(
                              width: 500,
                              child: ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return CupertinoAlertDialog(
                                        title: Text("Konfirmasi Logout"),
                                        content: Text(
                                            "Apakah kamu yakin ingin logout?"),
                                        actions: [
                                          TextButton(
                                            child: Text("Tidak"),
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(); // Close dialog
                                            },
                                          ),
                                          TextButton(
                                            child: Text("Iya"),
                                            onPressed: () {
                                              // If "Iya", logout and navigate to WelcomeScreen
                                              AuthenticationRepository.instance
                                                  .logout()
                                                  .then(
                                                (value) {
                                                  Navigator.of(context)
                                                      .pop(); // Close dialog before logout
                                                  Get.offAll(
                                                      () => WelcomeScreen());
                                                },
                                              );
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: const Text(
                                  'LOGOUT',
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  side: BorderSide.none,
                                  shape: StadiumBorder(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
