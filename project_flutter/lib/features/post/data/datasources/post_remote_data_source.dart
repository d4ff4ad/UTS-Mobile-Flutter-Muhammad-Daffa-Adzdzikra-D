import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getPosts();
  Future<PostModel> createPost(String title, String body, int userId);
  Future<PostModel> updatePost(int id, String title, String body, int userId);
  Future<void> deletePost(int id);
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final http.Client client;
  final String baseUrl = 'https://jsonplaceholder.typicode.com';

  PostRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PostModel>> getPosts() async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/posts'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => PostModel.fromJson(json)).toList();
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network or server error: $e');
    }
  }

  @override
  Future<PostModel> createPost(String title, String body, int userId) async {
    try {
      final response = await client.post(
        Uri.parse('$baseUrl/posts'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'title': title,
          'body': body,
          'userId': userId,
        }),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> jsonMap = json.decode(response.body);
        return PostModel.fromJson(jsonMap);
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network or server error: $e');
    }
  }

  @override
  Future<PostModel> updatePost(int id, String title, String body, int userId) async {
    try {
      final response = await client.put(
        Uri.parse('$baseUrl/posts/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'id': id,
          'title': title,
          'body': body,
          'userId': userId,
        }),
      );

      // JSONPlaceholder returns edited data. If server throws 500 for id > 100, we handle it gracefully.
      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> jsonMap = json.decode(response.body);
        return PostModel.fromJson(jsonMap);
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network or server error: $e');
    }
  }

  @override
  Future<void> deletePost(int id) async {
    try {
      final response = await client.delete(
        Uri.parse('$baseUrl/posts/$id'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network or server error: $e');
    }
  }
}
