import 'package:aplikasi_nagaricare/screens/auth/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:aplikasi_nagaricare/constants/app_colors.dart';
import 'package:aplikasi_nagaricare/constants/app_fonts.dart';
import 'package:aplikasi_nagaricare/constants/app_text.dart';
import 'package:aplikasi_nagaricare/screens/auth/forget_password/forget_password_options/forget_password_model_bottom_sheet.dart';
import 'package:get/get.dart';

class LogInForm extends StatelessWidget {
  const LogInForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final _formKey = GlobalKey<FormState>();

    return Container(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 30),
            TextFormField(
              controller: controller.email,
              decoration: InputDecoration(
                floatingLabelStyle: TextStyle(color: AppColors.accentColor),
                iconColor: AppColors.secondaryColor,
                label: const Text(
                  'Email',
                  style:
                      TextStyle(fontSize: 15, fontFamily: AppFonts.primaryFont),
                ),
                prefixIcon: const Icon(Icons.email_outlined),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide:
                      BorderSide(color: AppColors.accentColor, width: 2.5),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15), // Sudut radius 15
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            Obx(
              () => TextFormField(
                controller: controller.password,
                obscureText: controller.isPasswordHidden.value,
                decoration: InputDecoration(
                  floatingLabelStyle: TextStyle(color: AppColors.accentColor),
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
                    borderRadius: BorderRadius.circular(15), // Sudut radius 15
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
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
                    if (_formKey.currentState!.validate()) {
                      LoginController.instance.login();
                    }
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
