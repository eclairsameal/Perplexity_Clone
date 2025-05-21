import 'package:flutter/material.dart';
import 'package:perplexity/services/chat_web_service.dart';
import 'package:perplexity/theme/colors.dart';
import 'package:url_launcher/url_launcher.dart';  // 新增

class SourcesSection extends StatefulWidget {
  const SourcesSection({Key? key}) : super(key: key);

  @override
  _SourcesSectionState createState() => _SourcesSectionState();
}

class _SourcesSectionState extends State<SourcesSection> {
  List searchResults = [];

  @override
  void initState() {
    super.initState();
    ChatWebService().searchResultStream.listen((data){
      setState(() {
        searchResults = data['data'];
      });
    });
  }

  // 新增一個開啟url的函數
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      // 如果無法開啟url，可以顯示錯誤訊息或其他處理
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('無法開啟網址'))
      );
    }
  }

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
                  // 用InkWell包起來，並綁定點擊事件
                  InkWell(
                    onTap: () => _launchUrl(res['url']),
                    child: Text(
                      res['url'],
                      style: TextStyle(
                        color: Colors.blue, // 顯示成藍色讓人知道是可點擊
                        fontSize: 12,
                        decoration: TextDecoration.underline,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
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
