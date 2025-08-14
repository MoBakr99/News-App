import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/news/presentation/bloc/news_bloc.dart';
import 'package:news_app/features/news/presentation/pages/news_list_page.dart';
import 'package:news_app/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF21A6F3),
          secondary: Color(0xFF21A6F3),
          surface: Color(0xFF000B13),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF001B24),
          ),
        ),
      ),
      home: BlocProvider(
        create: (_) => di.sl<NewsBloc>(),
        child: const NewsListPage(),
      ),
    );
  }
}
