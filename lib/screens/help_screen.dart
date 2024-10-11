import 'package:aplikasi_nagaricare/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});
  // Helper function to launch a URL
  Future<void> _launchUrl(String url) async {
    final Uri _url = Uri.parse(url); // Use Uri.parse for better URL handling
    if (!await launchUrl(_url)) {
      throw 'Could not launch $url';
    }
  }

  // Helper function to open an app if installed or fallback to Play Store/App Store
  Future<void> _launchApp(String urlScheme, String fallbackUrl) async {
    try {
      final Uri _urlScheme = Uri.parse(urlScheme);
      final Uri _fallbackUrl = Uri.parse(fallbackUrl);

      // Try launching the app, if it fails, open the fallback URL (Play Store, web, etc.)
      if (!await launchUrl(_urlScheme, mode: LaunchMode.externalApplication)) {
        await launchUrl(_fallbackUrl, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      // Fallback to the app store or web if the app is not installed
      final Uri _fallbackUrl = Uri.parse(fallbackUrl);
      await launchUrl(_fallbackUrl, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Help Center'),
            actions: [
              GestureDetector(
                onTap: () => {print('ditekan')},
                child: Container(
                    margin: EdgeInsets.all(16), child: Icon(Icons.more_vert)),
              )
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
            FAQPage(),
            contactPage(),
          ]),
        ));
  }

  // FAQ Page
  Container FAQPage() {
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
          suffixIcon: Container(
            width: 100,
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  VerticalDivider(
                    color: Colors.black,
                    indent: 10,
                    endIndent: 10,
                    thickness: 0.1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Icon(Ionicons.filter_circle),
                  ),
                ],
              ),
            ),
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
          Container(
            margin: EdgeInsets.only(bottom: 10), // Space between tiles
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10), // Rounded corners
            ),
            child: ListTile(
              onTap: () => {
                _launchUrl('tel:+123456789'),
              },
              leading: Icon(Icons.call),
              title: Text('Customer Services'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10), // Space between tiles
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10), // Rounded corners
            ),
            child: ListTile(
              onTap: () => {
                _launchApp(
                    'whatsapp://send?phone=123456789', // WhatsApp direct app link
                    'https://play.google.com/store/apps/details?id=com.whatsapp')
              },
              leading: Icon(Ionicons.logo_whatsapp),
              title: Text('WhatsApp'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10), // Space between tiles
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10), // Rounded corners
            ),
            child: ListTile(
              onTap: () => {_launchUrl('https://www.banknagari.co.id/')},
              leading: Icon(Icons.web),
              title: Text('Website'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10), // Space between tiles
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10), // Rounded corners
            ),
            child: ListTile(
              onTap: () => {
                'fb://profile/your_facebook_id',
                'https://www.facebook.com/your_page_name'
              },
              leading: Icon(Ionicons.logo_facebook),
              title: Text('Facebook'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10), // Space between tiles
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10), // Rounded corners
            ),
            child: ListTile(
              onTap: () => {
                _launchApp('twitter://user?screen_name=example_user',
                    'https://twitter.com/example_user')
              },
              leading: Icon(Ionicons.logo_twitter),
              title: Text('Twitter'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10), // Space between tiles
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10), // Rounded corners
            ),
            child: ListTile(
              onTap: () => {
                _launchApp('instagram://user?username=bank_nagari',
                    'https://www.instagram.com/bank_nagari')
              },
              leading: Icon(Ionicons.logo_instagram),
              title: Text('Instagram'),
            ),
          ),
        ],
      ),
    );
  }
}
