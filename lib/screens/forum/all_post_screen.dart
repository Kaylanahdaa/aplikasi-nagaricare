import 'package:aplikasi_nagaricare/constants/app_colors.dart';
import 'package:aplikasi_nagaricare/widgets/posts_widget.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:get/get.dart';
import '../../controllers/home_controller.dart';

class AllPostScreen extends StatelessWidget {
  const AllPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomePageController controller = Get.put(HomePageController());

    return Scaffold(
      backgroundColor: AppColors.accentColor,
      body: ListView(children: <Widget>[
        Container(
          color: AppColors.accentColor,
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 5.0),
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Ionicons.arrow_back,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 5.0),
                  const Text(
                    "Semua Postingan",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  children: <Widget>[
                    // Search Bar
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          controller.search(value); // Call search function
                        },
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Find topics you like to read",
                          hintStyle:
                              TextStyle(color: Colors.white.withOpacity(0.6)),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.1),
                          prefixIcon:
                              const Icon(Ionicons.search, color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        PostsWidget()
        // Obx(() => PostsWidget(
        //     posts: controller.filteredPosts)), // Display filteredPosts
      ]),
    );
  }
}
