import 'package:floating_draggable_widget/floating_draggable_widget.dart';
import 'package:flutter/material.dart';

class FloatingChatWidget extends StatefulWidget {
  @override
  _FloatingChatWidgetState createState() => _FloatingChatWidgetState();
}

class _FloatingChatWidgetState extends State<FloatingChatWidget> {
  bool showContactList = true; // Controls which page to display

  @override
  Widget build(BuildContext context) {
    return FloatingDraggableWidget(
      floatingWidget: FloatingActionButton(
        onPressed: () {
          setState(() {
            showContactList = !showContactList; // Toggle view
          });
        },
        child: Icon(showContactList ? Icons.chat : Icons.people),
      ),
      floatingWidgetWidth: 60.0, // Adjust as needed
      floatingWidgetHeight: 60.0, // Adjust as needed
      mainScreenWidget: Container(
        width: 300,
        height: 500,
        child: showContactList ? buildContactList() : buildChatInterface(),
      ),
    );
  }

  // Builds the contact list with a search bar
  Widget buildContactList() {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: 'Search Contacts',
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (value) {
            // Handle search logic
          },
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 20, // Replace with actual contact count
            itemBuilder: (context, index) {
              return ListTile(
                title: Text("Contact $index"),
                onTap: () {
                  setState(() {
                    showContactList = false;
                  });
                },
              );
            },
          ),
        ),
      ],
    );
  }

  // Builds the chat interface
  Widget buildChatInterface() {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.arrow_back),
          title: Text("Chat with Contact"),
          onTap: () {
            setState(() {
              showContactList = true; // Go back to the contact list
            });
          },
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 20, // Replace with actual message count
            itemBuilder: (context, index) {
              return ListTile(
                title: Text("Message $index"),
              );
            },
          ),
        ),
        TextField(
          decoration: InputDecoration(
            labelText: 'Type a message',
            suffixIcon: Icon(Icons.send),
          ),
          onSubmitted: (value) {
            // Send message logic
          },
        ),
      ],
    );
  }
}
