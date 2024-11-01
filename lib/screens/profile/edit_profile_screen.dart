import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:aplikasi_nagaricare/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aplikasi_nagaricare/controllers/profile_controller.dart';

import 'widgets/picture_bottom_modal.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  Uint8List? _image;
  final TextEditingController emailController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  void selectImageFromGallery(ProfileController profileController) async {
    await _selectImage(profileController, ImageSource.gallery);
  }

  void openCamera(ProfileController profileController) async {
    await _selectImage(profileController, ImageSource.camera);
  }

  Future<void> _selectImage(
      ProfileController profileController, ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      Uint8List imgBytes = await image.readAsBytes();
      setState(() {
        _image = imgBytes;
      });
    }
  }

  // Function to delete the image and reset to default avatar
  void deleteImage() {
    setState(() {
      _image = null; // Set to null to reset to default avatar
    });
  }

  final ProfileController profileController = Get.put(ProfileController());
  @override
  void initState() {
    super.initState();
    profileController.fetchUserProfile();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final ProfileController profileController = Get.put(ProfileController());
    TextEditingController nameController =
        TextEditingController(text: profileController.name.value);
    TextEditingController emailController =
        TextEditingController(text: profileController.email.value);
    TextEditingController phoneController =
        TextEditingController(text: profileController.phone.value);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Container(),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Edit Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context)
              .unfocus(); // Hide the keyboard when tapping outside
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Profile picture with edit icon
              Container(
                height: 100,
                width: 100,
                margin: const EdgeInsets.only(top: 10),
                child: Stack(
                  children: <Widget>[
                    _image != null
                        ? CircleAvatar(
                            radius: 50,
                            backgroundImage: MemoryImage(
                                _image!), // Display new image as bytes
                          )
                        : profileController.profilePicture.value
                                .isNotEmpty // Check if URL is available
                            ? CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(profileController
                                    .profilePicture
                                    .value), // Display image from URL
                              )
                            : const CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.grey,
                                child: Icon(
                                  Icons.person,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        height: 25,
                        width: 25,
                        decoration: const BoxDecoration(
                          color: AppColors.accentColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: GestureDetector(
                            onTap: () => {
                              PictureBottomModal.show(
                                context: context,
                                onSelectGallery: () {
                                  selectImageFromGallery(profileController);
                                },
                                onOpenCamera: () {
                                  openCamera(profileController);
                                },
                                onDelete: () {
                                  deleteImage();
                                },
                              )
                            },
                            child: const Icon(
                              Icons.add_a_photo,
                              color: AppColors.backgroundColor,
                              size: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Editable Name field with pencil icon
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 200),
                      child: TextField(
                        controller: nameController,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                        decoration: const InputDecoration(
                          hintText: "Your Name",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 4.0),
                      child: Icon(
                        Icons.edit,
                        color: AppColors.accentColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Editable Email field
              TextField(
                readOnly: true,
                controller: emailController,
                focusNode: _focusNode,
                decoration: InputDecoration(
                  labelText: 'Your Email',
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(
                    color: _focusNode.hasFocus
                        ? Colors.grey
                        : Colors.grey, // Change color based on focus
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Editable Phone field
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: 'Your Phone',
                  focusedBorder: OutlineInputBorder(),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1)),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      width: deviceWidth * 0.35,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.alertColor,
                          side: BorderSide.none,
                          shape: const StadiumBorder(),
                        ),
                        child: const Text(
                          'CANCEL',
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                  const SizedBox(width: 30),
                  SizedBox(
                      width: deviceWidth * 0.35,
                      child: ElevatedButton(
                        onPressed: () {
                          // Log untuk memastikan data yang dikirim
                          print("Updating profile with: ");
                          print("Name: ${nameController.text}");
                          print("Email: ${emailController.text}");
                          print("Phone: ${phoneController.text}");

                          // Update observables dan panggil metode edit
                          profileController.name.value =
                              nameController.text.trim();
                          profileController.email.value =
                              emailController.text.trim();
                          profileController.phone.value =
                              phoneController.text.trim();

                          profileController.editUser();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accentColor,
                          side: BorderSide.none,
                          shape: const StadiumBorder(),
                        ),
                        child: const Text(
                          'SAVE',
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
