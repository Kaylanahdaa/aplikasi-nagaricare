import 'package:aplikasi_nagaricare/constants/app_colors.dart';
// import 'package:aplikasi_nagaricare/screens/forum/post_screen.dart';
import 'package:aplikasi_nagaricare/widgets/carousel_menu.dart';
import 'package:aplikasi_nagaricare/widgets/post_to_forum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../controllers/home_controller.dart';
// import '/widgets/posts.dart';
import 'package:ionicons/ionicons.dart';

import '../widgets/posts.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomePageController controller = Get.put(HomePageController());
    // Fetch posts when the widget is built
    controller.fetchPostsByCurrentUser();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => showPostTweetModal(context),
        backgroundColor: AppColors.secondaryColor,
        shape: const CircleBorder(),
        child: const Icon(Ionicons.chatbubble_ellipses_outline,
            color: AppColors.backgroundColor),
      ),
      backgroundColor: AppColors.accentColor,
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.secondaryColor,
          backgroundColor: AppColors.backgroundColor,
          onRefresh: () async {
            // Fetch the new posts when the user pulls to refresh
            await controller.fetchPostsByCurrentUser();
          },
          child: ListView(
            children: <Widget>[
              Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(color: AppColors.accentColor),
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
                    Posts(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
