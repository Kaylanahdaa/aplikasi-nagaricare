import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PostForumController extends GetxController {
  var forumText = ''.obs;
  var selectedImage = Rx<XFile?>(null);

  final ImagePicker _picker = ImagePicker();

  void pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = pickedFile;
    }
  }

  void removeImage() {
    selectedImage.value = null;
  }

  void postForum() {
    if (forumText.isNotEmpty || selectedImage.value != null) {
      // Handle post logic here
      print('Forum posted: $forumText');
      if (selectedImage.value != null) {
        print('With image: ${selectedImage.value!.path}');
      }
      Get.back(); // Close modal after posting
    }
  }
}
