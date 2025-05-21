import 'package:flutter/material.dart';
import 'package:perplexity/theme/colors.dart';
import 'package:perplexity/widgets/side_bar.dart';
import '../services/llama_chat_web_service.dart';
import '../widgets/only_llm_search.dart';

class OnlyLlmPage extends StatefulWidget {
  const OnlyLlmPage({super.key});

  @override
  State<OnlyLlmPage> createState() => _OnlyLlmPageState();
}

class _OnlyLlmPageState extends State<OnlyLlmPage> {
  @override
  void initState() {
    super.initState();
    LlamaChatWebService().connect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // side navbar
          SideBar(),
          Expanded(
            child: Column(
              children: [
                // search section
                Expanded(
                    child: OnlyLlmSearch()
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "Pro",
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.footerGrey,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "Enterprise",
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.footerGrey,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "Store",
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.footerGrey,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "Blog",
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.footerGrey,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "Careers",
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.footerGrey,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "English(English)",
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.footerGrey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // footer
              ],
            ),
          ),
        ],
      ),
    );
  }
}
