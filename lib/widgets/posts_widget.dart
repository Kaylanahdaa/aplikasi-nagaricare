import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../screens/forum/detail_post_screen.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostsWidget extends StatefulWidget {
  const PostsWidget({super.key});

  @override
  _PostsWidgetState createState() => _PostsWidgetState();
}

class _PostsWidgetState extends State<PostsWidget> {
  final HomePageController controller = Get.put(HomePageController());

  @override
  void initState() {
    super.initState();
    // Call the function to fetch posts for the current user
    controller.fetchPostsByCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    // Using Obx to reactively update the UI when posts change
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
              SizedBox(height: 20),
              Text(
                'Anda belum memiliki post',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Mulai untuk post sesuatu',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 300),
            ],
          ),
        );
      }

      // Return posts UI when posts are fetched
      return Column(
        children: controller.posts.map((post) {
          // Parse the createdAt string to DateTime
          DateTime createdAtDateTime = DateTime.parse(post.createdAt);

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailPostScreen(idPosts: post.idPosts),
                ),
              );
            },
            child: Container(
              height: 180,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      height: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.65,
                                      child: Text(
                                        post.title,
                                        style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: .4,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 2.0),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          post.email,
                                          style: TextStyle(
                                              color:
                                                  Colors.red.withOpacity(0.6)),
                                        ),
                                        const SizedBox(width: 15),
                                        // Use getTimeAgo to display the time difference
                                        Text(
                                          timeago.format(createdAtDateTime),
                                          style: TextStyle(
                                              color:
                                                  Colors.grey.withOpacity(0.6)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: Center(
                        child: Text(
                          post.content.length > 80
                              ? "${post.content.substring(0, 80)}.."
                              : post.content,
                          style: TextStyle(
                            color: Colors.grey.withOpacity(0.8),
                            fontSize: 16,
                            letterSpacing: .3,
                          ),
                        ),
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
