import 'dart:convert';

import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  var email = ''.obs;
  var phone = ''.obs;
  var displayName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      email.value = user.email ?? '';
      displayName.value = user.displayName ?? '';

      try {
        final response = await http.get(
          Uri.parse("http://192.168.100.110:3000/users/details?email=$email"),
        );

        print('Response status: ${response.statusCode}');
        print(
            'Response body: ${response.body}'); // Debug: Print the full response

        if (response.statusCode == 200) {
          final data = json.decode(response.body);

          // Ensure data is a Map<String, dynamic>
          if (data is Map<String, dynamic>) {
            displayName.value = data['name'] ?? '';
            phone.value = data['phone'] ?? '';
          } else {
            print("Expected a Map but got: ${data.runtimeType}");
          }
        } else {
          print("Failed to load user data with status: ${response.statusCode}");
        }
      } catch (e) {
        print("Error fetching user profile: $e");
      }
    }
  }

  Future<void> updateEmail(String newEmail) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // ignore: deprecated_member_use
      await user.updateEmail(newEmail);
      email.value = newEmail; // Update observable
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
