import 'package:aplikasi_nagaricare/repository/authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  // Controllers for input form
  final emailC = TextEditingController();
  final passwordC = TextEditingController();
  final fullnameC = TextEditingController();
  final phoneNoC = TextEditingController();

  // Function for registering user
  void registerUser() async {
    // Trimmed input values
    final email = emailC.text.trim();
    final password = passwordC.text.trim();
    final fullname = fullnameC.text.trim();
    final phone = phoneNoC.text.trim();

    // Check if fields are empty
    if (email.isEmpty ||
        password.isEmpty ||
        fullname.isEmpty ||
        phone.isEmpty) {
      Get.showSnackbar(const GetSnackBar(
        message: "Please fill in all fields.",
        duration: Duration(seconds: 3),
      ));
      return;
    }

    try {
      // Register user using Firebase Authentication
      await AuthenticationRepository.instance
          .createUserWithEmailAndPassword(email, password);

      // Proceed only if the user has been successfully registered in Firebase
      var currentUser = AuthenticationRepository.instance.firebaseUser.value;
      if (currentUser != null) {
        // Send the POST request to the backend
        var response = await http.post(
          Uri.parse(
              "http://192.168.100.110:3000/users"), // Ensure this API URL is correct
          body: {
            'email': email,
            'name': fullname,
            'phone': phone,
          },
        );

        // Check if the request was successful
        if (response.statusCode == 200) {
          Get.showSnackbar(const GetSnackBar(
            message: "Registration successful! Data sent to backend.",
            duration: Duration(seconds: 3),
          ));

          // Clear text fields after successful registration
          emailC.clear();
          passwordC.clear();
          fullnameC.clear();
          phoneNoC.clear();
        } else {
          Get.showSnackbar(const GetSnackBar(
            message: "Failed to send data to backend.",
            duration: Duration(seconds: 3),
          ));
        }
      } else {
        // Handle case where Firebase registration didn't succeed
        Get.showSnackbar(const GetSnackBar(
          message: "Firebase registration failed. No user created.",
          duration: Duration(seconds: 3),
        ));
      }
    } catch (e) {
      // Handle Firebase registration failure
      print('Firebase registration failed: $e');
      Get.showSnackbar(GetSnackBar(
        message: 'Registration failed: ${e.toString()}',
        duration: const Duration(seconds: 3),
      ));
    }
  }
}
