import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

// Features Auth
import 'package:project_flutter/features/auth/presentation/pages/login_page.dart';
// Features Home
import 'package:project_flutter/features/home/presentation/pages/main_page.dart';
// Features Profile
import 'package:project_flutter/features/profile/presentation/pages/profile_page.dart';
// Features Product
import 'package:project_flutter/features/product/presentation/pages/katalog_product_page.dart';
import 'package:project_flutter/features/product/presentation/pages/product_detail.dart';
// Features Notification
import 'package:project_flutter/features/notification/presentation/pages/notification_page.dart';
// Features Post
import 'package:project_flutter/features/post/presentation/pages/postingan_page.dart';
import 'package:project_flutter/features/post/presentation/providers/post_provider.dart';
import 'package:project_flutter/features/post/data/datasources/post_remote_data_source.dart';
import 'package:project_flutter/features/post/data/repositories/post_repository_impl.dart';
import 'package:project_flutter/features/post/domain/usecases/get_posts.dart';
import 'package:project_flutter/features/post/domain/usecases/create_post.dart';
import 'package:project_flutter/features/post/domain/usecases/update_post.dart';
import 'package:project_flutter/features/post/domain/usecases/delete_post.dart';

void main() {
  final httpClient = http.Client();
  final postRemoteDataSource = PostRemoteDataSourceImpl(client: httpClient);
  final postRepository = PostRepositoryImpl(remoteDataSource: postRemoteDataSource);
  
  // UseCases
  final getPosts = GetPosts(postRepository);
  final createPost = CreatePost(postRepository);
  final updatePost = UpdatePost(postRepository);
  final deletePost = DeletePost(postRepository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PostProvider(
            getPostsUseCase: getPosts,
            createPostUseCase: createPost,
            updatePostUseCase: updatePost,
            deletePostUseCase: deletePost,
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UTS Pemrograman Mobile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00AA13), // Warna Hijau khas Gojek
          primary: const Color(0xFF00AA13),
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black87),
          titleTextStyle: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00AA13),
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24), 
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[100],
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16), 
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFF00AA13), width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.red, width: 1),
          ),
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const MainPage(),
        '/profile': (context) => const ProfilePage(),
        '/katalog': (context) => const KatalogProduk(),
        '/notification': (context) => const NotificationPage(),
        '/detail': (context) => const ProductDetailPage(),
        '/postingan': (context) => const PostinganPage(),
      },
    );
  }
}
