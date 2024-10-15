import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aplikasi_nagaricare/constants/app_fonts.dart';
import 'package:aplikasi_nagaricare/constants/app_text.dart';
import 'package:aplikasi_nagaricare/screens/auth/forget_password/forget_password_mail/forget_password_mail.dart';
import 'package:aplikasi_nagaricare/screens/auth/forget_password/forget_password_options/forget_password_btn_widget.dart';
import 'package:aplikasi_nagaricare/screens/auth/forget_password/forget_password_phone/forget_password_phone.dart';

class ForgetPasswordScreen {
  static Future<dynamic> modalForgetPasword(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white, // Set background color to white
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20.0),
          ),
        ),
        padding: EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titleForgetPassword,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: AppFonts.primaryFont,
              ),
            ),
            Text(subtitleForgetPassword),
            SizedBox(height: 30.0),
            forgetPasswordBtnWidget(
              onTap: () {
                Navigator.pop(context);
                Get.to(() => ForgetPasswordMailScreen());
              },
              btnicon: Icons.mail_outline_rounded,
              title: 'Email',
              subTitle: resetViaEmail,
            ),
            SizedBox(height: 20.0),
            forgetPasswordBtnWidget(
              btnicon: Icons.mobile_friendly_rounded,
              title: 'Phone',
              subTitle: resetViaPhone,
              onTap: () {
                Navigator.pop(context);
                Get.to(() => ForgetPasswordPhoneScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
