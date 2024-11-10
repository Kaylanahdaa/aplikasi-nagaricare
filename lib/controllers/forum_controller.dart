import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '/models/post_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForumController extends GetxController {
  var posts = <Post>[].obs;
  var isLoading = true.obs;
  // Backend API URL (Adjust this URL to match your backend route)
  final String apiUrl = 'http://172.20.10.9:3000/posts';

  // Fetch all posts from the backend
  Future<void> fetchPosts() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);

        final user = FirebaseAuth.instance.currentUser;
        final String? email = user?.email;

        posts.value = jsonResponse.map((post) {
          return Post.fromJson({
            ...post,
            'email': email ?? '',
          });
        }).toList();
      } else {
        print('Failed to load posts');
      }
    } catch (e) {
      print('Error fetching posts: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<Post?> fetchPostById(int id) async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse('$apiUrl/$id'));

      if (response.statusCode == 200) {
        return Post.fromJson(json.decode(response.body));
      } else {
        print('Failed to load post');
        return null;
      }
    } catch (e) {
      print('Error fetching post by ID: $e');
      return null;
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }
}
