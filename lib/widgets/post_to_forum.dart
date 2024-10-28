import 'package:aplikasi_nagaricare/constants/app_colors.dart';
import 'package:aplikasi_nagaricare/controllers/post_forum_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class PostForumWidget extends StatelessWidget {
  final PostForumController postForumController =
      Get.put(PostForumController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.black),
                    onPressed: () => Get.back(),
                  ),
                  ElevatedButton(
                    onPressed: postForumController.postForum,
                    child: Text(
                      'Post',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accentColor,
                      shape: StadiumBorder(),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    onChanged: (text) => postForumController.title.value = text,
                    decoration: InputDecoration(
                      hintText: "Title",
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 32, // Larger font for title hint
                      ),
                      border: InputBorder.none,
                    ),
                    style:
                        TextStyle(fontSize: 32), // Larger font for title input
                  ),
                  SizedBox(height: 10),
                  TextField(
                    onChanged: (text) =>
                        postForumController.content.value = text,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: "What's happening?",
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      border: InputBorder.none,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showPostModal(BuildContext context) {
  showBarModalBottomSheet(
    context: context,
    builder: (context) => PostForumWidget(),
  );
}
