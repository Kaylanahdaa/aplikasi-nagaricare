import 'package:aplikasi_nagaricare/repository/authentication_repository/authentication_repository.dart';
import 'package:aplikasi_nagaricare/widgets/bottom_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();

  Future<void> login() async {
    try {
      String? error = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());
      if (error != null) {
        Get.showSnackbar(GetSnackBar(
          message: error,
          duration:
              Duration(seconds: 3), // Pastikan error berisi pesan yang sesuai
        ));
      } else {
        Get.offAll(() => BottomBarWidget());
      }
    } catch (e) {
      // Tangkap exception di sini
      Get.showSnackbar(GetSnackBar(
        message: 'An error occurred: $e',
      ));
    }
  }
}
