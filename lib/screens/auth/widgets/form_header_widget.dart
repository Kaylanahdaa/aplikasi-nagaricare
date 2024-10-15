import 'package:flutter/material.dart';
import 'package:aplikasi_nagaricare/constants/app_fonts.dart';

class FormHeaderWidget extends StatelessWidget {
  const FormHeaderWidget(
      {super.key,
      required this.image,
      required this.title,
      required this.subTitle});

  final String image, title, subTitle;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        Image(image: AssetImage(image), height: size.height * 0.2),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: AppFonts.primaryFont,
          ),
        ),
        Text(
          subTitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: AppFonts.primaryFont,
          ),
        ),
      ],
    );
  }
}
