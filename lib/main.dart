import 'package:aplikasi_nagaricare/firebase_options.dart';
import 'package:aplikasi_nagaricare/repository/authentication_repository/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'controllers/home_controller.dart';
import 'localization/messages.dart';

void main() async {
  WidgetsFlutterBinding();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));
  Get.put(HomePageController(), permanent: false);
  timeago.setLocaleMessages('en-short', EnShortMessages());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GetMaterialApp(
      title: 'NagariCare',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(textTheme).copyWith(
        bodyMedium: GoogleFonts.poppins(textStyle: textTheme.bodyMedium),
      )),
      home: CircularProgressIndicator(),
    );
  }
}
