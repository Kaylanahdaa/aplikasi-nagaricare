import 'package:aplikasi_nagaricare/constants/app_colors.dart';
import 'package:aplikasi_nagaricare/screens/forum/post_screen.dart';
import 'package:aplikasi_nagaricare/widgets/carousel_menu.dart';
import 'package:aplikasi_nagaricare/widgets/post_forum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../controllers/home_controller.dart';
// import '/widgets/posts.dart';
import 'package:ionicons/ionicons.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomePageController controller = Get.put(HomePageController());
    // Fetch posts when the widget is built
    controller.fetchPosts();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => showPostTweetModal(context),
        backgroundColor: AppColors.primaryColor,
        shape: const CircleBorder(),
        child: const Icon(Ionicons.chatbubble_ellipses_outline,
            color: Colors.white),
      ),
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(color: AppColors.primaryColor),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      "Forum NagariCare",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Find Topics you like to read",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 14.0,
                          ),
                        ),
                        const Icon(
                          Ionicons.search,
                          size: 20,
                          color: Colors.white,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35.0),
                  topRight: Radius.circular(35.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      "Update Terbaru Bank Nagari",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const CarouselMenu(),
                  const Padding(
                    padding: EdgeInsets.only(left: 20.0, top: 20.0),
                    child: Text(
                      "Postingan Anda",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Column(
                    children: controller.posts
                        .map((post) => GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => PostScreen(
                                              idPosts: post
                                                  .idPosts, // Assuming PostScreen expects idPosts.
                                            )));
                              },
                              child: Container(
                                height: 180,
                                margin: const EdgeInsets.all(15.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Colors.black26.withOpacity(0.05),
                                          offset: const Offset(0.0, 6.0),
                                          blurRadius: 10.0,
                                          spreadRadius: 0.10)
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 70,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.65,
                                                        child: Text(
                                                          post.title,
                                                          style: const TextStyle(
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              letterSpacing:
                                                                  .4),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 2.0),
                                                      Row(
                                                        children: <Widget>[
                                                          Text(
                                                            post.email, // Displaying post author email.
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .red
                                                                    .withOpacity(
                                                                        0.6)),
                                                          ),
                                                          const SizedBox(
                                                              width: 15),
                                                          Text(
                                                            post.createdAt, // Formatted date.
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.6)),
                                                          )
                                                        ],
                                                      )
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
                                              color:
                                                  Colors.grey.withOpacity(0.8),
                                              fontSize: 16,
                                              letterSpacing: .3,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                    ],
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
