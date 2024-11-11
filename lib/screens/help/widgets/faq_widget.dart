import 'package:flutter/material.dart';
import 'package:aplikasi_nagaricare/constants/app_colors.dart';
import '../../../models/faq_model.dart';
import '../../../data/faq_data.dart';

class FAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: faqListData.length,
        itemBuilder: (context, index) {
          final FAQ faq = faqListData[index];
          return Card(
            color: AppColors.accentColor,
            elevation: 0,
            margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
            child: ExpansionTile(
              iconColor: Colors.white,
              collapsedIconColor: Colors.white,
              tilePadding: EdgeInsets.symmetric(horizontal: 16.0),
              title: Text(
                faq.question,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              children: [
                Container(
                  color: AppColors.accentColor,
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    faq.answer,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
              backgroundColor: Colors.transparent,
            ),
          );
        },
      ),
    );
  }
}
