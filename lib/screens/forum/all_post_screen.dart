import 'package:aplikasi_nagaricare/constants/app_colors.dart';
import 'package:aplikasi_nagaricare/widgets/posts_widget.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class AllPostScreen extends StatelessWidget {
  const AllPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
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
                ),
              )
            ],
          ),
        ),
        PostsWidget(),
      ]),
    );
  }
}
