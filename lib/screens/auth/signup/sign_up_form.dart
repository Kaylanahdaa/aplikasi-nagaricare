import 'package:aplikasi_nagaricare/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:aplikasi_nagaricare/constants/app_colors.dart';
import 'package:aplikasi_nagaricare/constants/app_fonts.dart';
import 'package:get/get.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            TextFormField(
              decoration: InputDecoration(
                  floatingLabelStyle: TextStyle(color: AppColors.accentColor),
                  iconColor: AppColors.secondaryColor,
                  label: const Text(
                    'Nama Lengkap',
                    style: TextStyle(
                        fontSize: 15, fontFamily: AppFonts.primaryFont),
                  ),
                  prefixIcon: const Icon(Icons.person_outline_rounded),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.accentColor),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  )),
            ),
            const SizedBox(height: 10),
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
                  iconColor: AppColors.secondaryColor,
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
            const SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                  iconColor: AppColors.secondaryColor,
                  label: const Text(
                    'Nomor Telepon',
                    style: TextStyle(
                        fontSize: 15, fontFamily: AppFonts.primaryFont),
                  ),
                  prefixIcon: const Icon(Icons.numbers),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15), // Sudut radius 15
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
                    Get.to(() => MainScreen());
                  },
                  child: Text(
                    "Sign Up".toUpperCase(),
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
