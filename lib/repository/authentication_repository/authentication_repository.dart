import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:aplikasi_nagaricare/repository/authentication_repository/exceptions/login_email_password_failure.dart';
import 'package:aplikasi_nagaricare/repository/authentication_repository/exceptions/signup_email_password_failure.dart';
import 'package:aplikasi_nagaricare/screens/auth/welcome/welcome_screen.dart';
import 'package:aplikasi_nagaricare/screens/main_screen.dart';
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

  //Will be load when app launches this func will be called and set the firebaseUser state
  @override
  void onReady() {
    // Inisialisasi firebaseUser dan bind stream dari Firebase Authentication
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);

    // Tambahkan pemantauan state signed in/out menggunakan authStateChanges
    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });

    super.onReady(); // Pastikan untuk memanggil super.onReady()
  }

  /// If we are setting initial screen from here
  /// then in the main.dart => App() add CircularProgressIndicator()
// Tambahkan log untuk verifikasi
  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => const WelcomeScreen())
        : Get.offAll(() => MainScreen());
  }

  //FUNC
  Future<String?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // Add a debug log to verify user creation
      print('User created: ${_auth.currentUser?.email}');
      return null; // Return null if successful
    } on FirebaseAuthException catch (e) {
      final ex = SignupEmailPasswordFailure.code(e.code);
      print('Firebase Auth Exception: ${ex.message}');
      return ex.message; // Return the error message
    } catch (e) {
      const ex = SignupEmailPasswordFailure();
      print('General Exception: ${ex.message}');
      return ex.message; // Return a generic error message
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
    print("Logout function executed"); // Tambahkan log di sini
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? gUser = await googleSignIn.signIn();
      if (gUser == null) return; // User canceled sign-in

      final GoogleSignInAuthentication? gAuth = await gUser.authentication;
      if (gAuth?.accessToken == null || gAuth?.idToken == null) return;

      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth?.accessToken,
        idToken: gAuth?.idToken,
      );

      // Sign in to Firebase
      await _auth.signInWithCredential(credential);

      // Prepare the user data to send to the backend
      final String? email = _auth.currentUser?.email;
      final String? name = gUser.displayName; // Get user's name
      // You can also collect the phone number if needed

      // Send a POST request to your backend to save user data
      if (email != null && name != null) {
        final response = await http.post(
          Uri.parse(
              'http://http://192.168.100.110:3000/users/signin'), // Update with your backend URL
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'email': email,
            'name': name,
            // Add phone number if necessary
          }),
        );

        if (response.statusCode == 200) {
          // Successfully saved user data to MySQL
          print('User signed in and data saved successfully');
        } else {
          // Handle error from backend
          print('Failed to save user data: ${response.body}');
        }
      }

      Get.offAll(() => MainScreen());
    } catch (e) {
      print('Error signing in with Google: $e');
      // Show an error message to the user here
    }
  }
}
