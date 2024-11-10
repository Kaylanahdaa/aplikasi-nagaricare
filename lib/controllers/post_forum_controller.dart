import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

import 'home_controller.dart';

class PostForumController extends GetxController {
  final HomePageController controller = Get.put(HomePageController());
  final FirebaseAuth auth = FirebaseAuth.instance;

  var title = ''.obs;
  var content = ''.obs;

  // Function to get the user ID from the database based on the email
  Future<int?> getUserId(String email) async {
    try {
      final response = await http.get(
        Uri.parse("http://192.168.43.58:3000/users"),
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

  // Function to post data to the backend
  Future<void> postForum() async {
    final user = FirebaseAuth.instance.currentUser;
    final email = user?.email ?? ''; // Get email from logged-in user

    if (title.isNotEmpty && content.isNotEmpty && email.isNotEmpty) {
      print('Fetching user ID for email: $email'); // Debug: log the email
      final userId = await getUserId(email);

      if (userId != null) {
        print(
            'User ID fetched successfully: $userId'); // Debug: log the fetched user ID
        try {
          final response = await http.post(
            Uri.parse('http://192.168.43.58:3000/posts'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              "title": title.value,
              "content": content.value,
              "id_user": userId, // Send user ID instead of email
            }),
          );

          if (response.statusCode == 201) {
            FocusScope.of(Get.context!).unfocus();
            Get.back(); // Close modal after successful post

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
                'Post berhasil dibuat!',
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
            controller.fetchPostsByCurrentUser();
          } else {
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
                'Gagal membuat post',
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
        }
      } else {
        Get.snackbar('Error', 'User ID is null');
      }
    } else {
      Get.snackbar('Error', 'Title and content are required');
    }
  }
}
