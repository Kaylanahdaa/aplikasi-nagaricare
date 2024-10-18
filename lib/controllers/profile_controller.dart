import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileController extends GetxController {
  var email = ''.obs;
  var phone = ''.obs;
  var displayName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    // Change to return Future<void>
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      email.value = user.email ?? '';
      displayName.value = user.displayName ?? '';
      // Assuming you have a way to fetch the phone number
      phone.value = user.phoneNumber ?? '';
    }
  }

  Future<void> updateEmail(String newEmail) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // ignore: deprecated_member_use
      await user.updateEmail(newEmail);
      email.value = newEmail; // Update observable
    }
  }

  Future<void> updateDisplayName(String newName) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.updateProfile(displayName: newName);
      displayName.value = newName; // Update observable
    }
  }

  Future<void> updatePassword(String newPassword) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.updatePassword(newPassword);
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
