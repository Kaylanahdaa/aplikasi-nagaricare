import 'dart:convert';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  var email = ''.obs;
  var phone = ''.obs;
  var displayName = ''.obs;
  var selectedProfImage = Rx<XFile?>(null);

  final ImagePicker profPicker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      email.value = user.email ?? '';

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
            final userData = data.firstWhere(
              (user) => user['email'] == email.value,
              orElse: () => null,
            );

            if (userData != null) {
              displayName.value = userData['name'] ?? '';
              phone.value = userData['phone'] ?? '';
            } else {
              print("User not found for email: ${email.value}");
            }
          } else {
            print("Expected a List but got: ${data.runtimeType}");
          }
        } else {
          print("Failed to load user data with status: ${response.statusCode}");
        }
      } catch (e) {
        print("Error fetching user profile: $e");
      }
    }
  }

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
    if (selectedProfImage.value != null) {
      // TODO: Upload image and update user profile
    }
  }

  Future<void> updateDisplayName(String newName) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.updateProfile(displayName: newName);
      displayName.value = newName; // Update observable
    }
  }

  Future<void> updatePassword(String newPassword) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.updatePassword(newPassword);
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
