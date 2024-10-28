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
          FocusScope.of(Get.context!).unfocus(); // Close the keyboard
          Get.back(); // Close modal after successful post

          Get.snackbar(
            icon: Container(
              margin: EdgeInsets.all(8),
              child: Icon(
                Icons.check_circle_outline,
                color: Colors.green,
              ),
            ),
            'Success',
            'Post created successfully!',
            backgroundColor: Colors.white,
          );
          controller.fetchPostsByCurrentUser();
        } else {
          Get.snackbar(
            icon: Icon(
              Icons.cancel_outlined,
              color: Colors.red,
            ),
            'Error',
            'Failed to create post',
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
