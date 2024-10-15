import 'package:aplikasi_nagaricare/constants/app_colors.dart';
import 'package:aplikasi_nagaricare/constants/app_fonts.dart';
import 'package:aplikasi_nagaricare/constants/app_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aplikasi_nagaricare/constants/app_text.dart';
import 'package:aplikasi_nagaricare/screens/auth/login/login_screen.dart';
import 'package:aplikasi_nagaricare/screens/auth/signup/signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //image
              Container(
                  color: Colors.blueAccent[300],
                  child: Image(
                      image: const AssetImage(logoApp), height: height * 0.5)),

              // welcome text
              const Column(
                children: [
                  Text(
                    "Selamat Datang!",
                    style: TextStyle(
                        fontFamily: AppFonts.primaryFont,
                        fontWeight: FontWeight.w700,
                        fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    textStartLogin,
                    style: TextStyle(
                        fontFamily: AppFonts.primaryFont, fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              //button
              Row(
                // login button
                children: [
                  Expanded(
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            foregroundColor: AppColors.textColor,
                            padding: const EdgeInsets.symmetric(vertical: 10)),
                        onPressed: () {
                          Get.to(() => const LoginScreen());
                        },
                        child: Text(
                          "Log in".toUpperCase(),
                          style:
                              const TextStyle(fontFamily: AppFonts.primaryFont),
                        )),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            foregroundColor: AppColors.backgroundColor,
                            backgroundColor: AppColors.accentColor),
                        onPressed: () {
                          Get.to(() => const SignUpScreen());
                        },
                        child: Text(
                          "Sign Up".toUpperCase(),
                          style:
                              const TextStyle(fontFamily: AppFonts.primaryFont),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
