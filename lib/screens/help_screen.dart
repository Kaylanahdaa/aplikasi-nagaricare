import 'package:flutter/material.dart';

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
            bottom: TabBar(tabs: [
              Tab(
                text: 'Help',
              ),
              Tab(
                text: 'FAQ',
              )
            ]),
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
