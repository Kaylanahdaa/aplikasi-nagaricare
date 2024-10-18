import 'package:aplikasi_nagaricare/repository/authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aplikasi_nagaricare/constants/app_colors.dart';
import 'package:aplikasi_nagaricare/constants/app_fonts.dart';
import 'package:aplikasi_nagaricare/constants/app_image.dart';
import 'package:aplikasi_nagaricare/constants/app_text.dart';
import 'package:aplikasi_nagaricare/screens/auth/login/login_screen.dart';
import 'package:aplikasi_nagaricare/screens/auth/signup/sign_up_form.dart';
import 'package:aplikasi_nagaricare/screens/auth/widgets/form_header_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                const FormHeaderWidget(
                  image: logoApp,
                  title: 'Sign Up',
                  subTitle: subTitleSignUp,
                ),
                const SignUpForm(),
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
                          Get.to(() => const LoginScreen());
                        },
                        child: const Text.rich(TextSpan(children: [
                          TextSpan(
                              text: alreadyHaveAnAccount,
                              style: TextStyle(
                                  color: AppColors.textColor,
                                  fontSize: 15,
                                  fontFamily: AppFonts.primaryFont)),
                          TextSpan(
                              text: 'Log In',
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
      ),
    );
  }
}
