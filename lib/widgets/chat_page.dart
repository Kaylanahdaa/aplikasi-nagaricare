import 'package:aplikasi_nagaricare/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatPage extends StatelessWidget {
  ChatPage({
    required this.socket,
    required this.scrollController,
    required this.onCloseChat,
    required this.username, // Add username parameter
  });

  final IO.Socket socket;
  final ScrollController scrollController;
  final VoidCallback onCloseChat;
  final String username; // Define the username property

  @override
  Widget build(BuildContext context) {
    final messageController = TextEditingController();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 60,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ' $username', // Use the username here
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: onCloseChat,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: 1, // Replace with actual message count
              itemBuilder: (context, index) => ListTile(
                title: Text('User: pesan disini'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Ketik pesan...',
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: AppColors.secondaryColor),
                  onPressed: () {
                    final message = messageController.text;
                    socket.emit('sendMessage', message);
                    messageController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
