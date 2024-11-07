import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HelpScreenController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final Rxn<Map<String, dynamic>> userData = Rxn<Map<String, dynamic>>();
  final RxString searchResult = ''.obs;

  // Function to retrieve user ID based on email
  Future<int?> getUserId(String email) async {
    try {
      final response = await http.get(
        Uri.parse("http://192.168.100.110:3000/users"),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Check if data is a List
        if (data is List) {
          final userData = data.firstWhere(
            (user) => user['email'] == email,
            orElse: () => null,
          );

          if (userData != null) {
            int? userId = int.tryParse(userData['id_user']?.toString() ?? '');
            return userId;
          } else {
            Get.snackbar('Error', 'User not found for email: $email');
          }
        }
      } else {
        Get.snackbar(
            'Error', 'Failed to retrieve user ID: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
    return null;
  }

  // Function to search for the user by email, now utilizing getUserId
  Future<void> searchByEmail(String email) async {
    final userId = await getUserId(email);

    if (userId != null) {
      final url = Uri.parse("http://192.168.100.110:3000/users/$userId");

      try {
        final response = await http.get(url);

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);

          if (data != null && data['email'] == email) {
            userData.value = {
              'username': data['name'] ?? 'Unknown', // Provide default value
              'email': data['email'] ?? 'None', // Provide default value
              'profile': (data['profile_picture'] != null &&
                      data['profile_picture'].startsWith('http'))
                  ? data['profile_picture']
                  : 'http://192.168.100.110:3000/users/profilepicture/${data['id_user']}', // Provide default value if profile_picture is not a full URL
              'id_user': data['id_user'] ?? 0, // Provide default value
            };
            searchResult.value = '';
          } else {
            userData.value = null;
            searchResult.value = 'Email tidak ditemukan';
          }
        } else {
          userData.value = null;
          searchResult.value = 'Error retrieving data';
        }
      } catch (e) {
        userData.value = null;
        searchResult.value = 'Error: $e';
      }
    } else {
      searchResult.value = 'User ID not found for email: $email';
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
