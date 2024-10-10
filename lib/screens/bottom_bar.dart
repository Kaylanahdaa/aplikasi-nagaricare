import 'package:aplikasi_nagaricare/constants/app_colors.dart';
import 'package:aplikasi_nagaricare/screens/help_screen.dart';
import 'package:aplikasi_nagaricare/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/bottombarcontroller.dart';

class MainScreen extends StatelessWidget {
  buildBottomNavigationMenu(context, landingPageController) {
    final TextStyle unselectedLabelStyle = TextStyle(
        color: Colors.white.withOpacity(0.5),
        fontWeight: FontWeight.w500,
        fontSize: 12);

    final TextStyle selectedLabelStyle = TextStyle(
        color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12);

    return Obx(() => MediaQuery(
        data:
            MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
        child: SizedBox(
          height: 56,
          child: BottomNavigationBar(
            showUnselectedLabels: true,
            showSelectedLabels: true,
            onTap: landingPageController.changeTabIndex,
            currentIndex: landingPageController.tabIndex.value,
            backgroundColor: AppColors.primaryColor,
            unselectedItemColor: Colors.white.withOpacity(0.5),
            selectedItemColor: Colors.white,
            unselectedLabelStyle: unselectedLabelStyle,
            selectedLabelStyle: selectedLabelStyle,
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.only(bottom: 7),
                  child: Icon(
                    Icons.home,
                    size: 20.0,
                  ),
                ),
                label: 'Home',
                backgroundColor: Color.fromRGBO(36, 54, 101, 1.0),
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.only(bottom: 7),
                  child: Icon(
                    Icons.search,
                    size: 20.0,
                  ),
                ),
                label: 'Explore',
                backgroundColor: Color.fromRGBO(36, 54, 101, 1.0),
              ),
              // BottomNavigationBarItem(
              //   icon: Container(
              //     margin: EdgeInsets.only(bottom: 7),
              //     child: Icon(
              //       Icons.location_history,
              //       size: 20.0,
              //     ),
              //   ),
              //   label: 'Places',
              //   backgroundColor: Color.fromRGBO(36, 54, 101, 1.0),
              // ),
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
          ),
        )));
  }

  @override
  Widget build(BuildContext context) {
    final LandingPageController landingPageController =
        Get.put(LandingPageController(), permanent: false);
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar:
          buildBottomNavigationMenu(context, landingPageController),
      body: Obx(() => IndexedStack(
            index: landingPageController.tabIndex.value,
            children: [
              HelpScreen(),
              LoginScreen(),
              // PlacesPage(),
              // SettingsPage(),
            ],
          )),
    ));
  }
}
