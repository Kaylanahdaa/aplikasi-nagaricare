import 'dart:developer';

import 'package:get/get.dart';
import '../models/post_model.dart'; // Import your Post model
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePageController extends GetxController {
  var posts = <Post>[].obs; // Reactive list of Post objects

  @override
  void onInit() {
    fetchPosts();
    super.onInit();
  }

  // Fetch posts from API
  Future<void> fetchPosts() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.100.110:3000/posts'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        log("dfddf ${response.body}");
        posts.value = data.map((json) => Post.fromJson(json)).toList();
      } else {
        // Handle error
        print('Failed to load posts');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
