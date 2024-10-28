import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/home_controller.dart';
import 'package:timeago/timeago.dart' as timeago;
import '/models/post_model.dart'; // Ensure you import your Post model
import 'post_screen.dart';
import 'package:ionicons/ionicons.dart';

class Posts extends StatefulWidget {
  const Posts({super.key});

  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  final HomePageController controller = Get.put(HomePageController());

  @override
  void initState() {
    super.initState();
    // Fetch posts for the current user
    controller.fetchPostsByCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Check if posts are empty
      if (controller.posts.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.post_add,
                color: Colors.grey,
                size: 80,
              ),
              const SizedBox(height: 20),
              const Text(
                'Anda belum memiliki post',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Mulai untuk post sesuatu',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 300),
            ],
          ),
        );
      }

      return ListView(
        children: controller.posts.map((Post post) {
          DateTime createdAtDateTime = DateTime.parse(post.createdAt);

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PostScreen(idPosts: post.idPosts),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26.withOpacity(0.05),
                    offset: const Offset(0.0, 6.0),
                    blurRadius: 10.0,
                    spreadRadius: 0.10,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                post.title,
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: .4,
                                ),
                              ),
                              const SizedBox(height: 2.0),
                              Row(
                                children: <Widget>[
                                  Text(
                                    post.email,
                                    style: TextStyle(
                                      color: Colors.red.withOpacity(0.6),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Text(
                                    timeago.format(createdAtDateTime),
                                    style: TextStyle(
                                      color: Colors.grey.withOpacity(0.6),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Ionicons.chevron_forward_outline,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      post.content.length > 80
                          ? "${post.content.substring(0, 80)}..."
                          : post.content,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.8),
                        fontSize: 16,
                        letterSpacing: .3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      );
    });
  }
}
