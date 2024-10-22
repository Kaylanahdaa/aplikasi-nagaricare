import 'dart:convert'; // For json decoding
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '/models/post_model.dart'; // Make sure to adjust the import path

class ForumController extends GetxController {
  var posts = <Post>[].obs; // Observable list of posts
  var isLoading = true.obs; // Observable loading state

  // Backend API URL (Adjust this URL to match your backend route)
  final String apiUrl = 'http://192.168.100.110:3000/posts';

  // Fetch all posts from the backend
  Future<void> fetchPosts() async {
    try {
      isLoading(true); // Set loading state to true
      final response = await http.get(Uri.parse(apiUrl)); // Make GET request

      if (response.statusCode == 200) {
        // Decode the JSON response into a list of posts
        List jsonResponse = json.decode(response.body);
        posts.value = jsonResponse.map((post) => Post.fromJson(post)).toList();
      } else {
        // Handle error if response status is not 200
        print('Failed to load posts');
      }
    } catch (e) {
      // Handle any exceptions that occur
      print('Error fetching posts: $e');
    } finally {
      isLoading(false); // Set loading state to false
    }
  }

  // Fetch a specific post by its ID
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
    fetchPosts(); // Automatically fetch posts when the controller is initialized
  }
}
