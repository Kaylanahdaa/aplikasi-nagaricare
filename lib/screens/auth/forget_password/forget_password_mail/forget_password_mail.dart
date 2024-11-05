import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aplikasi_nagaricare/constants/app_colors.dart';
import 'package:aplikasi_nagaricare/constants/app_fonts.dart';
import 'package:aplikasi_nagaricare/constants/app_image.dart';
import 'package:aplikasi_nagaricare/constants/app_text.dart';
import 'package:aplikasi_nagaricare/screens/auth/forget_password/forget_password_otp/forget_password_otp.dart';
import 'package:aplikasi_nagaricare/screens/auth/widgets/form_header_widget.dart';

class ForgetPasswordMailScreen extends StatelessWidget {
  ForgetPasswordMailScreen({super.key});

  final _emailcontroller = TextEditingController();

  Future<void> passwordReset(BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailcontroller.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('Password reset link sent! Check your email'),
            );
          });
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Back arrow in the top left corner
            Positioned(
              left: 10.0,
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.black),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
            // Main content
            Center(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      Center(
                        child: FormHeaderWidget(
                          image: logoApp,
                          title: forgetPassword,
                          subTitle: subtitleForgetPassword,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Form(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _emailcontroller,
                              decoration: InputDecoration(
                                  iconColor: AppColors.secondaryColor,
                                  label: const Text(
                                    'Email',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: AppFonts.primaryFont),
                                  ),
                                  prefixIcon: const Icon(Icons.email_outlined),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  )),
                            ),
                            SizedBox(height: 20.0),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(15),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    foregroundColor: AppColors.backgroundColor,
                                    backgroundColor: AppColors.accentColor),
                                onPressed: () async {
                                  await passwordReset(context);
                                  Get.back();
                                  Get.back();
                                },
                                child: Text(
                                  "Next",
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontFamily: AppFonts.primaryFont),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
