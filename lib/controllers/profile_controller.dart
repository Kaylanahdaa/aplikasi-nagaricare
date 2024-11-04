import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  var email = ''.obs;
  var phone = ''.obs;
  var name = ''.obs;
  var profilePicture = ''.obs;
  var selectedProfImage = Rx<XFile?>(null);

  final ImagePicker profPicker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  // Function to get the user ID from the database based on the email
  Future<int?> getUserId(String email) async {
    try {
      final response = await http.get(
        Uri.parse("http://192.168.100.110:3000/users"),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Check if data is a List
        if (data is List) {
          // Find the user data matching the email
          final userData = data.firstWhere(
            (user) => user['email'] == email,
            orElse: () => null,
          );

          if (userData != null) {
            int? userId = int.tryParse(userData['id_user'].toString());
            print('Retrieved User ID: $userId'); // Debug: log user ID
            print(
                'Email associated with User ID: ${userData['email']}'); // Debug: log email
            return userId;
          } else {
            Get.snackbar('Error', 'User not found for email: $email');
          }
        } else {
          print("Expected a List but got: ${data.runtimeType}");
        }
      } else {
        Get.snackbar(
            'Error', 'Failed to retrieve user ID: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
      print('Error fetching user ID: $e'); // Debug: log the error
    }
    return null;
  }

  Future<void> fetchUserProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      email.value = user.email ?? '';

      try {
        final response = await http.get(
          Uri.parse("http://192.168.100.110:3000/users"),
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body);

          if (data is List) {
            final userData = data.firstWhere(
              (user) => user['email'] == email.value,
              orElse: () => null,
            );

            if (userData != null) {
              name.value = userData['name'] ?? '';
              phone.value = userData['phone'] ?? '';
              profilePicture.value = userData['profile_picture']
                      .startsWith('http')
                  ? userData['profile_picture']
                  : 'http://192.168.100.110:3000/users/profilepicture/${userData['id_user']}'; // Construct URL based on user ID
              print(
                  'Profile Picture URL: ${profilePicture.value}'); // Log the fetched URL
              // Log data yang baru diambil
              print('Fetched updated user data: $userData');
            }
          }
        }
      } catch (e) {
        print("Error fetching user profile: $e");
      }
    }
  }

  // Future<void> fetchProfilePicture(String userId) async {
  //   try {
  //     final response = await http.get(Uri.parse(
  //         'http://192.168.100.110:3000/users/profilepicture/$userId'));

  //     if (response.statusCode == 200) {
  //       profilePicture.value =
  //           'http://192.168.100.110:3000/users/profilepicture/$userId';
  //     } else {
  //       profilePicture.value = ''; // Set default or empty path if no image
  //     }
  //   } catch (e) {
  //     print("Error fetching profile picture: $e");
  //   }
  // }

  Future<XFile?> pickImage(ImageSource source) async {
    try {
      final XFile? image = await profPicker.pickImage(source: source);
      return image;
    } catch (e) {
      print("Error picking image: $e");
      return null;
    }
  }

  // Function to remove the selected image
  void removeImage() {
    selectedProfImage.value = null;
  }

  // Function to change profile picture (upload and save path)
  Future<void> changePicture() async {
    final user = FirebaseAuth.instance.currentUser;
    final currentEmail = user?.email ?? ''; // Get current email

    // Ensure user info is filled and profile picture is selected
    if (name.isEmpty || email.isEmpty || phone.isEmpty) {
      Get.snackbar('Error', 'Name, email, and phone are required');
      return;
    }

    if (selectedProfImage.value == null) {
      Get.snackbar('Error', 'No profile picture selected');
      return;
    }

    print(
        'Fetching user ID for email: $currentEmail'); // Debug: log current email
    final userId = await getUserId(currentEmail);

    if (userId == null) {
      Get.snackbar('Error', 'User ID is null');
      return;
    }

    print(
        'User ID fetched successfully: $userId'); // Debug: log the fetched user ID

    try {
      var request = http.MultipartRequest(
        'PUT',
        Uri.parse(
            'http://192.168.100.110:3000/users/uploadprofilepicture/$userId'),
      );

      // Attach the selected image file
      request.files.add(await http.MultipartFile.fromPath(
        'profile_picture',
        selectedProfImage.value!.path,
      ));

      // Send the request
      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final decodedData = json.decode(responseData);

        // Update profile picture URL in controller
        profilePicture.value = decodedData['profile_picture_url'] ?? '';
        print("Profile picture updated: ${profilePicture.value}");

        // Fetch the updated user profile
        fetchUserProfile();
      } else {
        print("Failed to upload image with status: ${response.statusCode}");
        Get.snackbar('Error', 'Failed to upload image');
      }
    } catch (e) {
      print("Error uploading profile picture: $e");
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }

  // Function to edit user data
  Future<void> editUser() async {
    final user = FirebaseAuth.instance.currentUser;
    final currentEmail = user?.email ?? ''; // Get current email

    if (name.isNotEmpty && email.isNotEmpty && phone.isNotEmpty) {
      print(
          'Fetching user ID for email: $currentEmail'); // Debug: log current email
      final userId = await getUserId(currentEmail);

      if (userId != null) {
        print(
            'User ID fetched successfully: $userId'); // Debug: log the fetched user ID
        try {
          if (currentEmail != email.value) {
            await user?.verifyBeforeUpdateEmail(email.value);
            print("Firebase email verification sent to new email");
          }

          final response = await http.put(
            Uri.parse('http://192.168.100.110:3000/users/$userId'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              "name": name.value,
              "email": email.value,
              "phone": phone.value.isEmpty ? "" : phone.value,
              "profile_picture": profilePicture.value,
            }),
          );

          if (response.statusCode == 200 || response.statusCode == 204) {
            // Success logic here
            FocusScope.of(Get.context!).unfocus();
            Get.back(); // Close modal after successful update

            Get.snackbar(
              '',
              '',
              titleText: Row(
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    color: Colors.green,
                    size: 24,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Success',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[800],
                    ),
                  ),
                ],
              ),
              messageText: Text(
                'Profil berhasil diperbarui!',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.white,
              borderRadius: 12,
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              duration: Duration(seconds: 3),
            );

            fetchUserProfile(); // Fetch updated user profile
          } else {
            log("Failed to update user profile with status: ${response.statusCode}");
            Get.snackbar(
              '',
              '',
              titleText: Row(
                children: [
                  Icon(
                    Icons.cancel_outlined,
                    color: Colors.red,
                    size: 24,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Error',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.red[800],
                    ),
                  ),
                ],
              ),
              messageText: Text(
                'Gagal memperbarui profil',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.white,
              borderRadius: 12,
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              duration: Duration(seconds: 3),
            );
          }
        } catch (e) {
          Get.snackbar('Error', 'An error occurred: $e');
          print('Error updating user profile: $e');
        }
      } else {
        Get.snackbar('Error', 'User ID is null');
      }
    } else {
      Get.snackbar('Error', 'Title and content are required');
    }
  }
}

Future<void> logout() async {
  await FirebaseAuth.instance.signOut();
}
