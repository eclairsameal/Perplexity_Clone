import 'package:flutter/material.dart';
import 'package:perplexity/pages/home_page.dart';
import 'package:perplexity/theme/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
      ),
      home: HomePage(),
    );
  }
}


