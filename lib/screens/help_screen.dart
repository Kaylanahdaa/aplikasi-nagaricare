import 'package:aplikasi_nagaricare/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Help Center'),
            actions: [
              Icon(Icons.more_vert),
            ],
            bottom: TabBar(
              tabs: [
                Tab(
                  text: 'FAQ',
                ),
                Tab(
                  text: 'Contact Us',
                )
              ],
              indicatorColor: AppColors.secondaryColor,
              indicatorWeight: 5,
            ),
          ),
          body: TabBarView(children: [
            Text(
              'test 1',
            ),
            Text('test 2')
          ]),
        ));
  }
}
