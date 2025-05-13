import 'package:flutter/material.dart';
import 'package:perplexity/theme/colors.dart';

class SourcesSection extends StatefulWidget {
  const SourcesSection({Key? key}) : super(key: key);

  @override
  _SourcesSectionState createState() => _SourcesSectionState();
}

class _SourcesSectionState extends State<SourcesSection> {
  List<Map<String, dynamic>> searchResults = [
    {
      'title':'ithub.com/karpathy/llm.c',
      'url':'https://github.com/karpathy/llm.c'
    },
    {
      'title':'deep-learning',
      'url':'https://leemeng.tw/deep-learning-for-everyone-understand-neural-net-and-linear-algebra.html'
    },
    {
      'title':'Empowering your AI applications with real-time,accurate search results tailored for LLMs and RAG.',
      'url':'https://tavily.com/'
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.source_outlined,
              color: Colors.white70,
            ),
            SizedBox(width: 8),
            Text(
              "Sources",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        const SizedBox(height: 15),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children:
            searchResults.map((res) {
              return Container(
                width: 100,
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.cardColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  children: [
                    Text(
                      res['title'],
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      res['url'],
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            }).toList(),
        )
      ],
    );
  }
}
