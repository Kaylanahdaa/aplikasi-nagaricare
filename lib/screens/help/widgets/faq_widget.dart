import 'package:flutter/material.dart';

class FaqWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _textField(),
          SizedBox(height: 10),
          // Example Question 1
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
          // Example Question 2
          ExpansionTile(
            title: Text('How do I contact customer support?'),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'You can contact customer support through the "Contact Us" tab or call us directly at +123456789.',
                ),
              ),
            ],
          ),
          // Example Question 3
          ExpansionTile(
            title: Text('How do I update my profile information?'),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'You can update your profile information in the settings menu after logging into your account.',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper function to create the search text field
  Widget _textField() {
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
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
