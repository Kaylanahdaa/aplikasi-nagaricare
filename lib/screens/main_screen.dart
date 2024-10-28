import 'package:aplikasi_nagaricare/constants/app_colors.dart';
import 'package:aplikasi_nagaricare/screens/help/help_screen.dart';
import 'package:aplikasi_nagaricare/screens/home_screen.dart';
// import 'package:aplikasi_nagaricare/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import '../controllers/bottombarcontroller.dart';
import 'profile/profile_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  buildBottomNavigationMenu(context, landingPageController) {
    final TextStyle unselectedLabelStyle = TextStyle(
        color: Colors.white.withOpacity(0.5),
        fontWeight: FontWeight.w500,
        fontSize: 12);

    const TextStyle selectedLabelStyle = TextStyle(
        color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12);

    return Obx(() => BottomNavigationBar(
          showUnselectedLabels: true,
          showSelectedLabels: true,
          onTap: landingPageController.changeTabIndex,
          currentIndex: landingPageController.tabIndex.value,
          backgroundColor: AppColors.accentColor,
          unselectedItemColor: Colors.white.withOpacity(0.5),
          selectedItemColor: Colors.white,
          unselectedLabelStyle: unselectedLabelStyle,
          selectedLabelStyle: selectedLabelStyle,
          items: [
            BottomNavigationBarItem(
              icon: Container(
                margin: const EdgeInsets.only(bottom: 8, top: 8),
                child: const Icon(
                  Ionicons.person,
                  size: 20.0,
                ),
              ),
              label: 'Profile',
              backgroundColor: const Color.fromRGBO(36, 54, 101, 1.0),
            ),
            BottomNavigationBarItem(
              icon: Container(
                margin: const EdgeInsets.only(bottom: 7),
                child: const Icon(
                  Ionicons.home,
                  size: 20.0,
                ),
              ),
              label: 'Home',
              backgroundColor: const Color.fromRGBO(36, 54, 101, 1.0),
            ),
            BottomNavigationBarItem(
              icon: Container(
                margin: const EdgeInsets.only(bottom: 7),
                child: const Icon(
                  Ionicons.help_circle,
                  size: 20.0,
                ),
              ),
              label: 'Help',
              backgroundColor: const Color.fromRGBO(36, 54, 101, 1.0),
            ),
            // BottomNavigationBarItem(
            //   icon: Container(
            //     margin: EdgeInsets.only(bottom: 7),
            //     child: Icon(
            //       Icons.settings,
            //       size: 20.0,
            //     ),
            //   ),
            //   label: 'Settings',
            //   backgroundColor: Color.fromRGBO(36, 54, 101, 1.0),
            // ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    final LandingPageController landingPageController =
        Get.put(LandingPageController(), permanent: false);
    return Scaffold(
      bottomNavigationBar:
          buildBottomNavigationMenu(context, landingPageController),
      body: Obx(() => IndexedStack(
            index: landingPageController.tabIndex.value,
            children: [
              const MyProfileScreen(),
              HomePage(),
              const HelpScreen(),
              // SettingsPage(),
            ],
          )),
    );
  }
}
