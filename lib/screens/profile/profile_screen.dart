import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:aplikasi_nagaricare/constants/app_colors.dart';
import 'package:aplikasi_nagaricare/repository/authentication_repository/authentication_repository.dart';
import 'package:aplikasi_nagaricare/screens/auth/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:aplikasi_nagaricare/controllers/profile_controller.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  Uint8List? _image;

  void selectImage(ProfileController profileController) async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      Uint8List imgBytes = await image.readAsBytes();
      setState(() {
        _image = imgBytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            'My Profile',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          // padding: EdgeInsets.all(5),
          child: Column(
            children: [
              Column(
                children: <Widget>[
                  Container(
                    height: 10 * 10,
                    width: 10 * 10,
                    margin: EdgeInsets.only(top: 10 * 3),
                    child: Stack(
                      children: <Widget>[
                        _image != null
                            ? CircleAvatar(
                                radius: 50,
                                backgroundImage: MemoryImage(_image!),
                              )
                            : const CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(
                                  'https://images.pexels.com/photos/1819650/pexels-photo-1819650.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
                                ),
                              ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            height: 10 * 2.5,
                            width: 10 * 2.5,
                            decoration: BoxDecoration(
                              color: AppColors.accentColor,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: GestureDetector(
                                onTap: () => selectImage(profileController),
                                child: Icon(
                                  LineAwesomeIcons.pen_solid,
                                  color: AppColors.backgroundColor,
                                  size: 10 * 1.5,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
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
                                onPressed: () {},
                                child: const Text(
                                  'Edit Profile',
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.accentColor,
                                  side: BorderSide.none,
                                  shape: StadiumBorder(),
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
                            const SizedBox(height: 10),
                            const Divider(),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: 500,
                              child: ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Konfirmasi Logout"),
                                        content: Text(
                                            "Apakah anda yakin ingin logout?"),
                                        actions: [
                                          TextButton(
                                            child: Text("Tidak"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: Text("Iya"),
                                            onPressed: () {
                                              AuthenticationRepository.instance
                                                  .logout()
                                                  .then(
                                                (value) {
                                                  Navigator.of(context).pop();
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

// var profilePicture = Column(
//   children: <Widget>[
//     Container(
//       height: 10 * 10,
//       width: 10 * 10,
//       margin: EdgeInsets.only(top: 10 * 3),
//       child: Stack(
//         children: <Widget>[
//           CircleAvatar(
//             radius: 10 * 5,
//             backgroundImage: NetworkImage(
//               'https://images.pexels.com/photos/1819650/pexels-photo-1819650.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomRight,
//             child: Container(
//               height: 10 * 2.5,
//               width: 10 * 2.5,
//               decoration: BoxDecoration(
//                 color: AppColors.accentColor,
//                 shape: BoxShape.circle,
//               ),
//               child: Center(
//                 child: GestureDetector(
//                   onTap: () {},
//                   child: Icon(
//                     LineAwesomeIcons.pen_solid,
//                     color: AppColors.backgroundColor,
//                     size: 10 * 1.5,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//   ],
// );
