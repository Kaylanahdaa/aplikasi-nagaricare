import 'dart:developer';
import 'package:get/get.dart';
import '../models/post_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePageController extends GetxController {
  var posts = <Post>[].obs;
  var filteredPosts = <Post>[].obs; // The list of filtered posts

  // Search function to filter posts based on the query
  void search(String query) {
    if (query.isEmpty) {
      filteredPosts
          .assignAll(posts); // Reset the filtered posts when query is empty
    } else {
      filteredPosts.value = posts
          .where(
              (post) => post.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    update(); // Notify GetBuilder to rebuild
  }

  // Fetch posts for the currently logged-in user
  Future<void> fetchPostsByCurrentUser() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final email = user.email;
      if (email != null && email.isNotEmpty) {
        final id_user = await fetchUserIdByEmail(email);

        if (id_user != null) {
          try {
            final response = await http.get(
              Uri.parse("http://192.168.100.110:3000/posts/user/$id_user"),
            );

            if (response.statusCode == 200) {
              final List<dynamic> data = json.decode(response.body);
              posts.assignAll(data.map((post) {
                return Post.fromJson({
                  ...post,
                  'email': email,
                });
              }).toList());
              filteredPosts
                  .assignAll(posts); // Initially set filteredPosts as all posts
            } else {
              log("Failed to load posts with status: ${response.statusCode}");
            }
          } catch (e) {
            log("Error fetching posts: $e");
          }
        }
      }
    }
  }
}

// Method to fetch user ID based on email
Future<int?> fetchUserIdByEmail(String email) async {
  try {
    final response = await http.get(
      Uri.parse("http://192.168.100.110:3000/users"),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      // log("Fetched user data: $data");

      final userData = data.firstWhere(
        (user) => user['email'] == email,
        orElse: () => null,
      );

      if (userData != null) {
        return userData['id_user'];
      } else {
        log("No user data found for email: $email");
      }
    } else {
      log("Failed to fetch user ID with status: ${response.statusCode}");
    }
  } catch (e) {
    log("Error fetching user ID: $e");
  }
  return null;
}
