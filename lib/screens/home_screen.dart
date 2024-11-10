import 'package:aplikasi_nagaricare/constants/app_colors.dart';
import 'package:aplikasi_nagaricare/constants/app_fonts.dart';
import 'package:aplikasi_nagaricare/constants/app_image.dart';
import 'package:aplikasi_nagaricare/screens/forum/all_post_screen.dart';
import 'package:aplikasi_nagaricare/widgets/carousel_menu.dart';
import 'package:aplikasi_nagaricare/widgets/post_to_forum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import 'package:ionicons/ionicons.dart';

import '../widgets/posts_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomePageController controller = Get.put(HomePageController());
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    // Fetch posts when the widget is built
    controller.fetchPostsByCurrentUser();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => showPostModal(context),
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
                decoration: const BoxDecoration(color: AppColors.accentColor),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Image(
                            image: AssetImage(logoApp),
                            width: deviceWidth *
                                0.20, // Set logo width as 25% of device width
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Forum NagariCare",
                            style: TextStyle(
                              fontFamily: AppFonts.primaryFont,
                              fontSize: deviceWidth *
                                  0.070, // Set font size as 7.5% of device width
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
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
                        "Latest Bank Nagari Update",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const CarouselMenu(),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Your Posts",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const AllPostScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                "See All",
                                style: TextStyle(color: AppColors.accentColor),
                              ))
                        ],
                      ),
                    ),
                    // Display the first 3 posts without any filtering
                    GetBuilder<HomePageController>(
                      builder: (_) {
                        return PostsWidget(
                          postLimit: 3,
                          posts: controller.posts, // Use posts directly here
                        );
                      },
                    )
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
