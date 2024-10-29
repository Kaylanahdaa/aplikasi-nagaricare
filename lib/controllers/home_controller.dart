import 'dart:developer';

import 'package:get/get.dart';
import '../models/post_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePageController extends GetxController {
  var posts = <Post>[].obs; // Reactive list of Post objects
  var filteredPosts = <Post>[].obs; // Reactive list for search results

  @override
  void onInit() {
    fetchPostsByCurrentUser();
    super.onInit();
  }

  // Fetch posts from API
  Future<void> fetchPosts() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.100.110:3000/posts'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        posts.value = data.map((json) => Post.fromJson(json)).toList();
      } else {
        // Handle error
        print('Failed to load posts');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // Fetch all posts specific by its Email
  // Fetch posts for the currently logged-in user
  Future<void> fetchPostsByCurrentUser() async {
    final user = FirebaseAuth.instance.currentUser; // Get the current user

    if (user != null) {
      final email = user.email; // Get the user's email

      try {
        final response = await http.get(
          Uri.parse("http://192.168.100.110:3000/posts/user/${email}"),
        );

        if (response.statusCode == 200) {
          final List<dynamic> data = json.decode(response.body);
          posts.value = data.map((post) => Post.fromJson(post)).toList();
          log("TES BY EMAIL ${response.body}");
        } else {
          print("Failed to load posts with status: ${response.statusCode}");
        }
      } catch (e) {
        print("Error fetching posts: $e");
      }
    } else {
      print("No user is currently logged in.");
    }
  }

  // Search function to filter posts by title
  void search(String query) {
    if (query.isEmpty) {
      filteredPosts.assignAll(posts); // Reset filteredPosts when query is empty
    } else {
      filteredPosts.value = posts
          .where(
              (post) => post.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}
