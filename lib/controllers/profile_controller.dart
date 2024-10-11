import 'package:get/get.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileController extends GetxController {
  var email = ''.obs;
  var phone = ''.obs;
  var password =
      ''.obs; // Note: You shouldn't display passwords like this in production.

  @override
  void onInit() {
    super.onInit();
    fetchProfileData();
  }

  void fetchProfileData() async {
    // Assuming you have a Firestore collection named 'users' and a document for the current user
    // DocumentSnapshot userDoc = await FirebaseFirestore.instance
    //     .collection('users')
    //     .doc('your_user_id')
    //     .get();

    // Update the observable variables with the fetched data
    // email.value = userDoc['email'] ?? '';
    // phone.value = userDoc['phone'] ?? '';
    // password.value = userDoc['password'] ?? ''; // Fetch password carefully
  }
}
