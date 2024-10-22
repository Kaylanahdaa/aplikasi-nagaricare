import 'package:aplikasi_nagaricare/controllers/forum_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/models/post_model.dart';
import 'package:ionicons/ionicons.dart';

class PostScreen extends StatefulWidget {
  final int idPosts; // ID of the post to fetch
  PostScreen({required this.idPosts});

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final ForumController forumController =
      Get.put(ForumController()); // Initialize controller

  @override
  void initState() {
    super.initState();
    // Fetch the post data using the ID passed to the screen
    forumController.fetchPostById(widget.idPosts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() {
          if (forumController.isLoading.value) {
            return Center(
                child: CircularProgressIndicator()); // Show loading spinner
          }

          Post? post = forumController.posts
              .firstWhereOrNull((p) => p.idPosts == widget.idPosts);
          if (post == null) {
            return Center(
                child: Text("Post not found")); // Handle if post is not found
          }

          return ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                child: Row(
                  children: <Widget>[
                    IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Ionicons.arrow_back,
                          size: 20,
                          color: Colors.black,
                        )),
                    SizedBox(width: 5.0),
                    Text(
                      "View Post",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26.withOpacity(0.05),
                          offset: Offset(0.0, 6.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.10)
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 60,
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        child: Text(
                                          post.email,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: .4),
                                        ),
                                      ),
                                      SizedBox(height: 2.0),
                                      Text(
                                        post.createdAt, // Use the formatted date
                                        style: TextStyle(color: Colors.grey),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: Text(
                          post.title,
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black.withOpacity(0.8),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        post.content,
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.4),
                            fontSize: 17,
                            letterSpacing: .2),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
