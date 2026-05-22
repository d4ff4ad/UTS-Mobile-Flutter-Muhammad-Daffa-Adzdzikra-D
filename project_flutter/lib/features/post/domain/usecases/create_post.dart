import '../entities/post.dart';
import '../repositories/post_repository.dart';

class CreatePost {
  final PostRepository repository;

  CreatePost(this.repository);

  Future<Post> call(String title, String body, int userId) async {
    return await repository.createPost(title, body, userId);
  }
}
