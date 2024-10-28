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

  // Function to post data to the backend
  Future<void> postForum() async {
    final User? user = auth.currentUser;
    final email = user?.email ?? ''; // Get email from logged-in user

    if (title.isNotEmpty && content.isNotEmpty && email.isNotEmpty) {
      try {
        final response = await http.post(
          Uri.parse('http://192.168.100.110:3000/posts'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            "title": title.value,
            "content": content.value,
            "email": email, // Send user email automatically
          }),
        );

        if (response.statusCode == 201) {
          // Close the keyboard and the modal after a successful post
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
      Get.snackbar('Error', 'Title and content are required');
    }
  }
}
