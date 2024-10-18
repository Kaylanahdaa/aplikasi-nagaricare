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
      firebaseUser.value != null
          ? Get.offAll(() => WelcomeScreen())
          : Get.to(() => const WelcomeScreen());
    } on FirebaseAuthException catch (e) {
      final ex = SignupEmailPasswordFailure.code(e.code);
      return ex.message;
    } catch (_) {
      const ex = SignupEmailPasswordFailure();
      return ex.message;
    }
    return null;
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

  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? gUser = await googleSignIn.signIn();
      if (gUser == null) return; // User canceled sign-in

      final GoogleSignInAuthentication? gAuth = await gUser.authentication;
      if (gAuth?.accessToken == null || gAuth?.idToken == null) return;

      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth?.accessToken,
        idToken: gAuth?.idToken,
      );

      await _auth.signInWithCredential(credential);
      Get.offAll(() => MainScreen());
    } catch (e) {
      print('Error signing in with Google: $e');
      // You can also show an error message to the user here
    }
  }
}
