import 'package:aplikasi_nagaricare/screens/auth/controllers/signup_controller.dart';
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
    final controller = Get.put(SignupController());
    final _formKey = GlobalKey<FormState>();

    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            TextFormField(
              controller: controller.fullnameC,
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
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                        BorderSide(color: AppColors.accentColor, width: 2.5),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  )),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: controller.emailC,
              decoration: InputDecoration(
                  floatingLabelStyle: TextStyle(color: AppColors.accentColor),
                  iconColor: AppColors.secondaryColor,
                  label: const Text(
                    'Email',
                    style: TextStyle(
                        fontSize: 15, fontFamily: AppFonts.primaryFont),
                  ),
                  prefixIcon: const Icon(Icons.email_outlined),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                        BorderSide(color: AppColors.accentColor, width: 2.5),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15), // Sudut radius 15
                  )),
            ),
            const SizedBox(height: 10),
            Obx(
              () => TextFormField(
                controller: controller.passwordC,
                obscureText: controller.isPasswordHidden.value,
                decoration: InputDecoration(
                    floatingLabelStyle: TextStyle(color: AppColors.accentColor),
                    iconColor: AppColors.secondaryColor,
                    label: const Text(
                      'Password',
                      style: TextStyle(
                          fontSize: 15, fontFamily: AppFonts.primaryFont),
                    ),
                    prefixIcon: const Icon(Icons.fingerprint),
                    suffix: GestureDetector(
                      child: Icon(
                        controller.isPasswordHidden.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                        size: 20,
                      ),
                      onTap: () {
                        controller.isPasswordHidden.value =
                            !controller.isPasswordHidden.value;
                      },
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          BorderSide(color: AppColors.accentColor, width: 2.5),
                    ),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(15), // Sudut radius 15
                    )),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: controller.phoneNoC,
              decoration: InputDecoration(
                  floatingLabelStyle: TextStyle(color: AppColors.accentColor),
                  iconColor: AppColors.secondaryColor,
                  label: const Text(
                    'Nomor Telepon',
                    style: TextStyle(
                        fontSize: 15, fontFamily: AppFonts.primaryFont),
                  ),
                  prefixIcon: const Icon(Icons.numbers),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                        BorderSide(color: AppColors.accentColor, width: 2.5),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15), // Sudut radius 15
                  )),
            ),
            SizedBox(height: 20),
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
                    if (_formKey.currentState!.validate()) {
                      // Call registerUser without needing to pass parameters
                      SignupController.instance.registerUser();
                    }
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
