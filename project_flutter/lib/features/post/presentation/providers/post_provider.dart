import 'package:flutter/material.dart';
import '../../domain/entities/post.dart';
import '../../domain/usecases/get_posts.dart';
import '../../domain/usecases/create_post.dart';
import '../../domain/usecases/update_post.dart';
import '../../domain/usecases/delete_post.dart';

class PostProvider with ChangeNotifier {
  final GetPosts getPostsUseCase;
  final CreatePost createPostUseCase;
  final UpdatePost updatePostUseCase;
  final DeletePost deletePostUseCase;

  List<Post> _posts = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Post> get posts => _posts;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  PostProvider({
    required this.getPostsUseCase,
    required this.createPostUseCase,
    required this.updatePostUseCase,
    required this.deletePostUseCase,
  });

  Future<void> fetchPosts() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final fetched = await getPostsUseCase();
      _posts = List<Post>.from(fetched);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addPost(String title, String body) async {
    _isLoading = true;
    notifyListeners();

    try {
      // JSONPlaceholder userId is arbitrary, let's use 1
      final remotePost = await createPostUseCase(title, body, 1);
      
      // JSONPlaceholder always returns id: 101. To support multiple items in list, let's assign a unique ID locally
      int localId = remotePost.id;
      if (_posts.any((p) => p.id == localId)) {
        // Find max ID and increment
        localId = _posts.map((p) => p.id).reduce((a, b) => a > b ? a : b) + 1;
      }

      final newPost = remotePost.copyWith(id: localId);
      _posts.insert(0, newPost);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e, stack) {
      debugPrint('Exception in addPost: $e');
      debugPrint('Stacktrace: $stack');
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> editPost(int id, String title, String body) async {
    _isLoading = true;
    notifyListeners();

    try {
      if (id <= 100) {
        // Real ID on server, call remote update
        final updatedPost = await updatePostUseCase(id, title, body, 1);
        final index = _posts.indexWhere((p) => p.id == id);
        if (index != -1) {
          _posts[index] = updatedPost;
        }
      } else {
        // Mock created post, update locally only
        final index = _posts.indexWhere((p) => p.id == id);
        if (index != -1) {
          _posts[index] = _posts[index].copyWith(title: title, body: body);
        }
      }
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> removePost(int id) async {
    _isLoading = true;
    notifyListeners();

    try {
      if (id <= 100) {
        // Real ID on server, call remote delete
        await deletePostUseCase(id);
      }
      // If it is mock or server delete succeeded, remove from list
      _posts.removeWhere((p) => p.id == id);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
