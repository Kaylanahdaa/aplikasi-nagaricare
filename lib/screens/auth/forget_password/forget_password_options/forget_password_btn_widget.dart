import 'package:flutter/material.dart';
import 'package:aplikasi_nagaricare/constants/app_fonts.dart';

class forgetPasswordBtnWidget extends StatelessWidget {
  const forgetPasswordBtnWidget({
    required this.btnicon,
    required this.title,
    required this.subTitle,
    required this.onTap,
    super.key,
  });

  final IconData btnicon;
  final String title, subTitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.grey[200]),
        child: Row(
          children: [
            Icon(btnicon, size: 50.0),
            SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFonts.primaryFont,
                  ),
                ),
                Text(subTitle)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
