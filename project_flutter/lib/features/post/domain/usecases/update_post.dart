import '../entities/post.dart';
import '../repositories/post_repository.dart';

class UpdatePost {
  final PostRepository repository;

  UpdatePost(this.repository);

  Future<Post> call(int id, String title, String body, int userId) async {
    return await repository.updatePost(id, title, body, userId);
  }
}
