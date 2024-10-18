import 'package:aplikasi_nagaricare/repository/authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:aplikasi_nagaricare/constants/app_colors.dart';
import 'package:aplikasi_nagaricare/constants/app_fonts.dart';
import 'package:aplikasi_nagaricare/constants/app_image.dart';
import 'package:aplikasi_nagaricare/constants/app_text.dart';
import 'package:get/get.dart';
import 'package:aplikasi_nagaricare/screens/auth/login/log_in_form.dart';
import 'package:aplikasi_nagaricare/screens/auth/widgets/form_header_widget.dart';
import 'package:aplikasi_nagaricare/screens/auth/signup/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              const FormHeaderWidget(
                image: logoApp,
                title: 'Log In',
                subTitle: subTitleSignUp,
              ),
              const LogInForm(),
              Column(
                children: [
                  const Text('OR',
                      style: TextStyle(
                          color: AppColors.textColor,
                          fontSize: 15,
                          fontFamily: AppFonts.primaryFont)),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      onPressed: () =>
                          AuthenticationRepository().signInWithGoogle(),
                      icon: const Image(
                        image: AssetImage(logoGoogle),
                        width: 20.0,
                      ),
                      label: Text(signInGoogle.toUpperCase(),
                          style: const TextStyle(
                              color: AppColors.textColor,
                              fontSize: 15,
                              fontFamily: AppFonts.primaryFont)),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Get.to(() => const SignUpScreen());
                      },
                      child: const Text.rich(TextSpan(children: [
                        TextSpan(
                            text: dontHaveAnAccount,
                            style: TextStyle(
                                color: AppColors.textColor,
                                fontSize: 15,
                                fontFamily: AppFonts.primaryFont)),
                        TextSpan(
                            text: 'Sign Up',
                            style: TextStyle(
                                color: AppColors.accentColor,
                                fontSize: 15,
                                fontFamily: AppFonts.primaryFont))
                      ]))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
