import 'package:aplikasi_nagaricare/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatPage extends StatelessWidget {
  final IO.Socket socket;
  final ScrollController scrollController;
  final VoidCallback onCloseChat;
  final String username;
  final List<Map<String, dynamic>> messages;

  ChatPage({
    required this.socket,
    required this.scrollController,
    required this.onCloseChat,
    required this.username,
    required this.messages,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController messageController = TextEditingController();

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
          // Header
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
                Text('$username',
                    style: TextStyle(color: Colors.white, fontSize: 18)),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: onCloseChat,
                ),
              ],
            ),
          ),
          // Messages List
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return ListTile(
                  title: Text(message['sender'] ?? 'User'),
                  subtitle: Text(message['content'] ?? ''),
                );
              },
            ),
          ),
          // Input Field for new message
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (messageController.text.isNotEmpty) {
                      socket.emit('sendMessage', {
                        'sender': username,
                        'content': messageController.text,
                      });

                      // Clear the message input field after sending
                      messageController.clear();
                    }
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
