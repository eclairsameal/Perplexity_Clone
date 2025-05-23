import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perplexity/pages/chat_page.dart';
import 'package:perplexity/pages/home_page.dart';
import 'package:perplexity/pages/only_llm_page.dart';
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
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomePage(),
        '/onlyllm': (context) => OnlyLlmPage(),
        // 其他頁面
      },
      title: 'Perplexity Clone',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.submitButton),
        // Modify the color of the input box mouse.
        textTheme: GoogleFonts.interTextTheme(
          ThemeData.dark().textTheme.copyWith(
            bodyMedium: const TextStyle(
              fontSize: 15,
              color: AppColors.whiteColor,
            )
          ),
        ),
      ),
      home: OnlyLlmPage(),
      // Test ChatPage code.
      // home: const ChatPage(
      //     question: "Who is ave mujica ？",
      // ),
    );
  }
}


