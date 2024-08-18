import 'package:flutter_clean_architecture/core/network/network_info.dart';
import 'package:flutter_clean_architecture/features/posts/data/datasources/post_local_data_source.dart';
import 'package:flutter_clean_architecture/features/posts/data/datasources/post_remote_data_source.dart';
import 'package:flutter_clean_architecture/features/posts/data/repostiroies/post_repostories_impl.dart';
import 'package:flutter_clean_architecture/features/posts/domain/repositories/post_repostiroieas.dart';
import 'package:flutter_clean_architecture/features/posts/domain/usecases/add_post.dart';
import 'package:flutter_clean_architecture/features/posts/domain/usecases/delete_post.dart';
import 'package:flutter_clean_architecture/features/posts/domain/usecases/get_all_posts.dart';
import 'package:flutter_clean_architecture/features/posts/domain/usecases/update_post.dart';
import 'package:flutter_clean_architecture/features/posts/presentation/bloc/add_delete_update/add_delete_update_post_cubit.dart';
import 'package:flutter_clean_architecture/features/posts/presentation/bloc/getPost_cubit/posts_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  /// features posts
// Bloc
  sl.registerFactory(
    () => PostsCubit(getAllPostsUseCases:  sl()),
  );
  sl.registerFactory(
    () => AddDeleteUpdatePostCubit(addPostcase:  sl(),deletePostcase: sl(),updatePostcase:  sl()),
  );
//use cases
  sl.registerLazySingleton(
    () => ( GetAllPostsUseCases(repostiroieas:  sl())),
  );
  sl.registerLazySingleton(
    () => DeletePost(sl()),
  );
  sl.registerLazySingleton(
    () => UpdatePost(sl()),
  );
  sl.registerLazySingleton(
    () => AddPost(sl()),
  );
// Repostories
  sl.registerLazySingleton<PostRepostiroieas>(() => PostsRepostoriesImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));
// Data Sources
  sl.registerLazySingleton<PostRemoteDataSource>(
    () => PostRemoteDataSourceImpl(client:  sl()),
  );
  sl.registerLazySingleton<PostLocalDataSource>(
    () => PostLocalDataSourceImpl(sharedPreferences: sl()),
  );

  /// core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkinfoImpl(sl()),
  );

  /// External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(
    () => http.Client(),
  );
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
