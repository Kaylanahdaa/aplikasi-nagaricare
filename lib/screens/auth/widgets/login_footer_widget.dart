import 'package:flutter/material.dart';
import 'package:aplikasi_nagaricare/constants/app_image.dart';

class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(image: const AssetImage(LogoBank), height: size.height * 0.2),
        const Text("Login"),
        const Text("data")
      ],
    );
  }
}
