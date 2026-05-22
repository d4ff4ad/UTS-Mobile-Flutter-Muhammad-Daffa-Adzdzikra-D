import '../../domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';
import '../datasources/post_remote_data_source.dart';
import '../../../../core/error/failures.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;

  PostRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Post>> getPosts() async {
    try {
      return await remoteDataSource.getPosts();
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<Post> createPost(String title, String body, int userId) async {
    try {
      return await remoteDataSource.createPost(title, body, userId);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<Post> updatePost(int id, String title, String body, int userId) async {
    try {
      return await remoteDataSource.updatePost(id, title, body, userId);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<void> deletePost(int id) async {
    try {
      await remoteDataSource.deletePost(id);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
