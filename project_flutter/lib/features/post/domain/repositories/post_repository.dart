import '../entities/post.dart';

abstract class PostRepository {
  Future<List<Post>> getPosts();
  Future<Post> createPost(String title, String body, int userId);
  Future<Post> updatePost(int id, String title, String body, int userId);
  Future<void> deletePost(int id);
}
