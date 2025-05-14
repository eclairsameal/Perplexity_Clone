import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:perplexity/theme/colors.dart';
import 'package:perplexity/widgets/side_bar.dart';

import '../widgets/answer_section.dart';
import '../widgets/sources_section.dart';

class ChatPage extends StatelessWidget {
  final String question;
  const ChatPage({super.key, required this.question});

  // StreamBuilder(
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          kIsWeb ? SideBar() : SizedBox(),
          const SizedBox(width: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical:  50.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          question,
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold
                          )
                      ),
                      SizedBox(height: 15),
                      // sources
                      SourcesSection(),
                      SizedBox(height: 15),
                      //answer section
                      AnswerSection(),
                    ]
                ),
              ),
            ),
          ),
          // kIsWeb ? Placeholder(
          //   strokeWidth: 0,
          //   color: AppColors.background,
          // )
          // :SizedBox(),
        ],
      ),
    );
  }
}
