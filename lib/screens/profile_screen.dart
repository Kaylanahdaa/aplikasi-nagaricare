import 'package:aplikasi_nagaricare/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart'; // Import your ProfileController

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController =
        Get.put(ProfileController()); // Initialize the controller

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'My Profile',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(58),
          child: Column(
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                      'https://images.pexels.com/photos/1819650/pexels-photo-1819650.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
                ),
              ),
              const SizedBox(height: 10),
              Text('Nama',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              Text('Pekerjaan', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () => {},
                  child: const Text(
                    'Edit Profile',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      side: BorderSide.none,
                      shape: StadiumBorder()),
                ),
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),
              // EDIT FROM HERE
              ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: AppColors.secondaryColor.withOpacity(0.1),
                  ),
                  child: const Icon(
                    LineAwesomeIcons.envelope,
                    color: AppColors.secondaryColor,
                  ),
                ),
                title: Text('Your Email'),
                subtitle: Text("ini email")
                // Obx(() => Text(profileController.email.value))
                ,
                // trailing: Container(
                //   width: 30,
                //   height: 30,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(100),
                //     color: Colors.grey.withOpacity(0.1),
                //   ),
                //   child: const Icon(
                //     LineAwesomeIcons.angle_right_solid,
                //     size: 18,
                //     color: Colors.grey,
                //   ),
                // ),
              ),
              ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: AppColors.secondaryColor.withOpacity(0.1),
                  ),
                  child: const Icon(
                    LineAwesomeIcons.phone_solid,
                    color: AppColors.secondaryColor,
                  ),
                ),
                title: Text('Your Phone'),
                subtitle: Text("ini phone")
                // Obx(() => Text(profileController.phone.value))
                ,
                // trailing: Container(
                //   width: 30,
                //   height: 30,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(100),
                //     color: Colors.grey.withOpacity(0.1),
                //   ),
                //   child: const Icon(
                //     LineAwesomeIcons.angle_right_solid,
                //     size: 18,
                //     color: Colors.grey,
                //   ),
                // ),
              ),
              ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: AppColors.secondaryColor.withOpacity(0.1),
                  ),
                  child: const Icon(
                    LineAwesomeIcons.lock_solid,
                    color: AppColors.secondaryColor,
                  ),
                ),
                title: Text('Password'),
                subtitle: Text("Ini pass")
                // Obx(() => Text(profileController.password.value))
                ,
                trailing: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.grey.withOpacity(0.1),
                  ),
                  child: const Icon(
                    LineAwesomeIcons.eye,
                    size: 18,
                    color: Colors.grey,
                  ),
                ),
              ),
              const Divider(),
              SizedBox(
                width: 500,
                child: ElevatedButton(
                  onPressed: () => {},
                  child: const Text(
                    'LOGOUT',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      side: BorderSide.none,
                      shape: StadiumBorder()),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
