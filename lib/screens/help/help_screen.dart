import 'dart:convert';
import 'package:aplikasi_nagaricare/constants/app_colors.dart';
import 'package:aplikasi_nagaricare/widgets/chat_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widgets/floating_chat_widget.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:aplikasi_nagaricare/controllers/help_screen_controller.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final HelpScreenController _controller = Get.put(HelpScreenController());
  final DraggableScrollableController _sheetController =
      DraggableScrollableController();
  late IO.Socket _socket;
  bool isChatting = false;

  @override
  void initState() {
    super.initState();
    _initializeSocket();
  }

  void _initializeSocket() {
    _socket = IO.io('http://192.168.100.110:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    _socket.connect();
    _socket.on('connect', (_) => print('Connected to Socket.IO server'));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Help Center'),
          backgroundColor: Colors.white,
          bottom: TabBar(
            tabs: [
              Tab(text: 'FAQ'),
              Tab(text: 'Contact Us'),
            ],
            indicatorColor: AppColors.secondaryColor,
            indicatorWeight: 5,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        body: Stack(
          children: [
            TabBarView(
              children: [
                FAQPage(),
                contactPage(),
              ],
            ),
            DraggableScrollableSheet(
              controller: _sheetController,
              initialChildSize: 0.09,
              minChildSize: 0.09,
              maxChildSize: 1.0,
              builder: (context, scrollController) {
                return isChatting
                    ? ChatPage(
                        socket: _socket,
                        scrollController: scrollController,
                        onCloseChat: () {
                          setState(() {
                            isChatting = false;
                          });
                        },
                        username:
                            _controller.userData.value?['username'] ?? 'User',
                      )
                    : _buildProfileSearch(scrollController);
              },
            ),
          ],
        ),
        floatingActionButton: isChatting
            ? FloatingActionButton(
                shape: CircleBorder(),
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      NetworkImage('${_controller.userData.value?['profile']}'),
                ),
                onPressed: () {
                  setState(() {
                    isChatting = false;
                  });
                },
              )
            : null,
      ),
    );
  }

  Widget _buildProfileSearch(ScrollController scrollController) {
    return GestureDetector(
      onTap: () {
        _sheetController.animateTo(
          1.0,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: ListView(
          controller: scrollController,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              height: 60,
              padding: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.chat_bubble_outline, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    'Chat',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: _controller.searchController,
                onSubmitted: (value) {
                  _controller.searchByEmail(value);
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.all(15),
                  hintText: 'Search email here',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Icon(Icons.search),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: const Color.fromARGB(255, 205, 205, 205),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Obx(() {
              final user = _controller.userData.value;
              final resultMessage = _controller.searchResult.value;

              if (user != null) {
                return ListTile(
                  onTap: () {
                    _socket.emit('joinRoom',
                        user['id_user']); // Emit join event to server
                    setState(() {
                      isChatting = true; // Switch to chat mode
                    });
                  },
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      '${user['profile']}?v=${DateTime.now().millisecondsSinceEpoch}',
                    ),
                  ),
                  title: Text(user['username'] ?? 'Unknown User'),
                  subtitle: Text(user['email'] ?? 'No Email'),
                );
              } else if (resultMessage.isNotEmpty) {
                return Center(child: Text(resultMessage));
              } else {
                return Container();
              }
            }),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _socket.dispose();
    super.dispose();
  }

  Container FAQPage() {
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _textField(),
          SizedBox(height: 10),
          ExpansionTile(
            title: Text('How do I reset my password?'),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'To reset your password, go to the login screen, click "Forgot Password", and follow the instructions sent to your email.',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  TextField _textField() {
    return TextField(
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.all(15),
          hintText: 'Search for Help',
          hintStyle: TextStyle(
            color: Color(0xffDDDADA),
            fontSize: 14,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12),
            child: Icon(Icons.search),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none)),
    );
  }

  Container contactPage() {
    return Container(
      margin: EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ListTile(
            onTap: () => {_controller.searchByEmail('example@domain.com')},
            leading: Icon(Icons.call),
            title: Text('Customer Services'),
          ),
        ],
      ),
    );
  }
}
