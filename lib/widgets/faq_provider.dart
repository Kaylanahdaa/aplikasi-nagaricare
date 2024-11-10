import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FAQProvider with ChangeNotifier {
  List<FAQ> _faqList = [];
  bool _isLoading = true;

  List<FAQ> get faqList => _faqList;
  bool get isLoading => _isLoading;

  Future<void> fetchFAQs() async {
    _isLoading = true;
    notifyListeners();

    // Simulasi pengambilan data
    await Future.delayed(Duration(seconds: 2)); // Ganti dengan API call

    _faqList = [
      FAQ(
          question: "Apa itu Flutter?",
          answer: "Flutter adalah toolkit UI dari Google."),
      FAQ(
          question: "Apa itu Dart?",
          answer: "Dart adalah bahasa pemrograman oleh Google."),
    ];

    _isLoading = false;
    notifyListeners();
  }
}
