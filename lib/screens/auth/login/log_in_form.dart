import 'package:flutter/material.dart';
import 'package:aplikasi_nagaricare/constants/app_colors.dart';
import 'package:aplikasi_nagaricare/constants/app_fonts.dart';
import 'package:aplikasi_nagaricare/constants/app_text.dart';
import 'package:aplikasi_nagaricare/screens/auth/forget_password/forget_password_options/forget_password_model_bottom_sheet.dart';
import 'package:aplikasi_nagaricare/screens/auth/welcome/welcome_screen.dart';
import 'package:get/get.dart';

class LogInForm extends StatelessWidget {
  const LogInForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        child: Column(
          children: [
            const SizedBox(height: 30),
            TextFormField(
              decoration: InputDecoration(
                  iconColor: AppColors.secondaryColor,
                  label: const Text(
                    'Email',
                    style: TextStyle(
                        fontSize: 15, fontFamily: AppFonts.primaryFont),
                  ),
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15), // Sudut radius 15
                  )),
            ),
            const SizedBox(height: 10),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                  label: const Text(
                    'Password',
                    style: TextStyle(
                        fontSize: 15, fontFamily: AppFonts.primaryFont),
                  ),
                  prefixIcon: const Icon(Icons.fingerprint),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15), // Sudut radius 15
                  )),
            ),

            // FORGET PASSWORD
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {
                    ForgetPasswordScreen.modalForgetPasword(context);
                  },
                  child: const Text(
                    forgetPassword,
                    style: TextStyle(
                        color: AppColors.accentColor,
                        fontSize: 15,
                        fontFamily: AppFonts.primaryFont),
                  )),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      foregroundColor: AppColors.backgroundColor,
                      backgroundColor: AppColors.accentColor),
                  onPressed: () {
                    Get.off(() => const WelcomeScreen());
                  },
                  child: Text(
                    "Log in".toUpperCase(),
                    style: const TextStyle(
                        fontSize: 15, fontFamily: AppFonts.primaryFont),
                  )),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
