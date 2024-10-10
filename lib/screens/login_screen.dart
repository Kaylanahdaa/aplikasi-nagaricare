import 'package:aplikasi_nagaricare/constants/app_image.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: const Scaffold(
        body: Column(
          children: [
            //image
            Image(
              image: AssetImage(LogoBank),
            ),

            // welcome text
            Text("Selamat Datang di NagariCare!"),
            Text("data")
            //button
          ],
        ),
      ),
    );
  }
}
