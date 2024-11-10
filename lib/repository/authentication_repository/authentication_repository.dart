import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aplikasi_nagaricare/repository/authentication_repository/exceptions/login_email_password_failure.dart';
import 'package:aplikasi_nagaricare/repository/authentication_repository/exceptions/signup_email_password_failure.dart';
import 'package:aplikasi_nagaricare/screens/auth/welcome/welcome_screen.dart';
import 'package:aplikasi_nagaricare/widgets/bottom_bar_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  //Variables
  final googleSignIn = GoogleSignIn(
    clientId:
        '1060173404019-uldaupl8mogkiqch4t0l9p4uems9gjke.apps.googleusercontent.com',
  );
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);

    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });

    super.onReady();
  }

  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => const WelcomeScreen())
        : Get.offAll(() => BottomBarWidget());
  }

  Future<String?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print('User created: ${_auth.currentUser?.email}');
      return null;
    } on FirebaseAuthException catch (e) {
      final ex = SignupEmailPasswordFailure.code(e.code);
      print('Firebase Auth Exception: ${ex.message}');
      return ex.message;
    } catch (e) {
      const ex = SignupEmailPasswordFailure();
      print('General Exception: ${ex.message}');
      return ex.message;
    }
  }

  Future<String?> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      final ex = LoginEmailPasswordFailure.code(e.code);
      return ex.message;
    }

    return null;
  }

  Future<void> logout() async {
    await _auth.signOut();
    print("Logout function executed");
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? gUser = await googleSignIn.signIn();
      if (gUser == null) return;

      final GoogleSignInAuthentication? gAuth = await gUser.authentication;
      if (gAuth?.accessToken == null || gAuth?.idToken == null) return;

      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth?.accessToken,
        idToken: gAuth?.idToken,
      );

      // Sign in to Firebase
      await _auth.signInWithCredential(credential);

      final String? email = _auth.currentUser?.email;
      final String? name = gUser.displayName;

      // Send a POST request to your backend to save user data
      if (email != null && name != null) {
        final response = await http.post(
          Uri.parse('http://172.20.10.9:3000/users/signin'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'email': email,
            'name': name,
          }),
        );

        if (response.statusCode == 200) {
          print('User signed in and data saved successfully');
        } else {
          print('Failed to save user data: ${response.body}');
        }
      }

      Get.offAll(() => BottomBarWidget());
    } catch (e) {
      print('Error signing in with Google: $e');
    }
  }
}
