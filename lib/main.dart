import 'package:aplikasi_nagaricare/screens/auth/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aplikasi_nagaricare/screens/auth/welcome/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'NagariCare',
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}
