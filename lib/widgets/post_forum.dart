import 'dart:io';
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
                      backgroundColor: Colors.blue,
                      shape: StadiumBorder(),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage:
                        NetworkImage('https://via.placeholder.com/150'),
                    radius: 24,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      onChanged: (text) =>
                          postForumController.forumText.value = text,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: "What's happening?",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Obx(() {
              if (postForumController.selectedImage.value != null) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Stack(
                    children: [
                      Image.file(
                        File(postForumController.selectedImage.value!.path),
                        height: 150,
                      ),
                      Positioned(
                        right: 0,
                        child: IconButton(
                          icon: Icon(Icons.cancel, color: Colors.red),
                          onPressed: postForumController.removeImage,
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return SizedBox.shrink();
              }
            }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.photo, color: Colors.blue),
                    onPressed: postForumController.pickImage,
                  ),
                  Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showPostTweetModal(BuildContext context) {
  showBarModalBottomSheet(
    context: context,
    builder: (context) => PostForumWidget(),
  );
}
