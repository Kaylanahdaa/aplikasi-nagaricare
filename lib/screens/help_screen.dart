import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

class HelpScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            // Top bar
            Positioned(
              top: 15,
              left: 10,
              child: Container(
                width: 371,
                height: 20,
                child: Stack(
                  children: <Widget>[
                    // Time display
                    Positioned(
                      top: 1.5,
                      left: 0,
                      child: Text(
                        '9:41',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.9),
                          fontFamily: 'Inter',
                          fontSize: 15,
                        ),
                      ),
                    ),
                    // SVG icons (adjust with correct paths and positions)
                    Positioned(
                      top: 2.8,
                      left: 283,
                      child: Transform.rotate(
                        angle: -90 * (math.pi / 180),
                        child: Container(
                          child: Text("Test"),
                        ),
                      ),
                    ),
                    // Other SVGs and icons can be placed similarly
                  ],
                ),
              ),
            ),
            // Welcome text
            Positioned(
              top: 100,
              left: 20,
              child: Text(
                'Welcome!',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
            ),
            // Buttons (General, Account, Payment, etc.)
            Positioned(
              top: 167,
              left: 13,
              child: Row(
                children: <Widget>[
                  _buildCategoryButton('General', Colors.black, Colors.white),
                  SizedBox(width: 20),
                  _buildCategoryButton('Account', Colors.white, Colors.black),
                  SizedBox(width: 20),
                  _buildCategoryButton('Payment', Colors.white, Colors.black),
                ],
              ),
            ),
            // Search bar
            Positioned(
              top: 214,
              left: 13,
              child: Container(
                width: 367,
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.search, color: Colors.grey),
                    SizedBox(width: 20),
                    Text(
                      'Search for help',
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Montserrat',
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Example help topics
            Positioned(
              top: 300,
              left: 20,
              child: Column(
                children: [
                  _buildHelpTopic('How do I manage my notifications?'),
                  SizedBox(height: 20),
                  _buildHelpTopic(
                      'How do I start a guided meditation session?'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryButton(String text, Color bgColor, Color textColor) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.black),
      ),
      padding: EdgeInsets.symmetric(horizontal: 28, vertical: 12),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 16,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildHelpTopic(String text) {
    return Container(
      width: 347,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: Color.fromRGBO(250, 250, 250, 1),
        borderRadius: BorderRadius.circular(23),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    );
  }
}
