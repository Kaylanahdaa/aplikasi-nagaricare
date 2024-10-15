import 'package:flutter/material.dart';
import 'package:aplikasi_nagaricare/constants/app_colors.dart';
import 'package:aplikasi_nagaricare/constants/app_fonts.dart';
import 'package:aplikasi_nagaricare/constants/app_image.dart';
import 'package:aplikasi_nagaricare/constants/app_text.dart';
import 'package:aplikasi_nagaricare/screens/auth/widgets/form_header_widget.dart';

class ForgetPasswordPhoneScreen extends StatelessWidget {
  const ForgetPasswordPhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
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
                          decoration: InputDecoration(
                              iconColor: AppColors.secondaryColor,
                              label: const Text(
                                'Phone',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: AppFonts.primaryFont),
                              ),
                              prefixIcon:
                                  const Icon(Icons.mobile_friendly_outlined),
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
                                      borderRadius: BorderRadius.circular(15)),
                                  foregroundColor: AppColors.backgroundColor,
                                  backgroundColor: AppColors.accentColor),
                              onPressed: () {},
                              child: Text(
                                "Next",
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontFamily: AppFonts.primaryFont),
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
