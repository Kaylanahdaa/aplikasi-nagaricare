import 'package:aplikasi_nagaricare/constants/app_colors.dart';
import 'package:flutter/material.dart';
import '/widgets/popular_topics.dart';
import '/widgets/posts.dart';
import '/widgets/top_bar.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:ionicons/ionicons.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
          child: ListView(
        children: <Widget>[
          Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: AppColors.primaryColor),
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Forum NagariCare",
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 8.0),
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
                      Icon(
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
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35.0),
                      topRight: Radius.circular(35.0))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // TopBar(),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      "DIBAWAH INI CAROUSEL",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  PopularTopics(),
                  Padding(
                    padding: EdgeInsets.only(left: 20.0, top: 20.0),
                    child: Text(
                      "Postingan Terbaru",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Posts()
                ],
              ))
        ],
      )),
    );
  }
}
