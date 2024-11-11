import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ionicons/ionicons.dart';

class ContactWidget extends StatelessWidget {
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
    return Container(
      padding: EdgeInsets.all(35),
      child: Column(
        children: [
          _buildContactTile(
            icon: Icons.call,
            title: 'Customer Services',
            onTap: () => _launchUrl('tel:+123456789'),
          ),
          _buildContactTile(
            icon: Ionicons.logo_whatsapp,
            title: 'WhatsApp',
            onTap: () => _launchApp(
              'whatsapp://send?phone=123456789', // WhatsApp direct app link
              'https://play.google.com/store/apps/details?id=com.whatsapp',
            ),
          ),
          _buildContactTile(
            icon: Icons.web,
            title: 'Website',
            onTap: () => _launchUrl('https://www.banknagari.co.id/'),
          ),
          _buildContactTile(
            icon: Ionicons.logo_facebook,
            title: 'Facebook',
            onTap: () => _launchApp(
              'fb://profile/your_facebook_id',
              'https://www.facebook.com/your_page_name',
            ),
          ),
          _buildContactTile(
            icon: Ionicons.logo_twitter,
            title: 'Twitter',
            onTap: () => _launchApp(
              'twitter://user?screen_name=example_user',
              'https://twitter.com/example_user',
            ),
          ),
          _buildContactTile(
            icon: Ionicons.logo_instagram,
            title: 'Instagram',
            onTap: () => _launchApp(
              'instagram://user?username=bank_nagari',
              'https://www.instagram.com/bank_nagari',
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to create contact tiles
  Widget _buildContactTile(
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon),
        title: Text(title),
      ),
    );
  }
}
