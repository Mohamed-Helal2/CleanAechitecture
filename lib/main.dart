import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/core/theme/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/features/posts/presentation/bloc/add_delete_update/add_delete_update_post_cubit.dart';
import 'package:flutter_clean_architecture/features/posts/presentation/bloc/getPost_cubit/posts_cubit.dart';
import 'package:flutter_clean_architecture/features/posts/presentation/pages/posts_page.dart';
import 'injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostsCubit>(
          create: (_) => di.sl<PostsCubit>()..getallpost(),
        ),
        BlocProvider<AddDeleteUpdatePostCubit>(
          create: (_) => di.sl<AddDeleteUpdatePostCubit>(),
        ),
      ],
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        home: const PostsPage(),
        theme: appTheme,
      ),
    );
  }
}
