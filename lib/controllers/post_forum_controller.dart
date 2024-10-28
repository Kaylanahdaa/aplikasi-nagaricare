import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ionicons/ionicons.dart';

import 'home_controller.dart';

class PostForumController extends GetxController {
  final HomePageController controller = Get.put(HomePageController());
  var title = ''.obs;
  var content = ''.obs;
  var email = ''.obs; // Add an email field for the post request

  // Function to post data to the backend
  Future<void> postForum() async {
    if (title.isNotEmpty && content.isNotEmpty && email.isNotEmpty) {
      try {
        final response = await http.post(
          Uri.parse('http://192.168.100.110:3000/posts'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            "title": title.value,
            "content": content.value,
            "email": email.value, // Include the email in the request body
          }),
        );

        if (response.statusCode == 201) {
          // Status 201 for Created
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
              backgroundColor: Colors.white);
          controller.fetchPostsByCurrentUser();
        } else {
          Get.snackbar(
              icon: Icon(
                Icons.cancel_outlined,
                color: Colors.red,
              ),
              'Error',
              'Failed to create post');
        }
      } catch (e) {
        Get.snackbar('Error', 'An error occurred: $e');
      }
    } else {
      Get.snackbar('Error', 'Title, content, and email are required');
    }
  }
}
