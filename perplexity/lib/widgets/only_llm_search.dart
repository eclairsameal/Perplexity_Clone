import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/llama_chat_web_service.dart';
import '../theme/colors.dart';

class OnlyLlmSearch extends StatefulWidget {
  const OnlyLlmSearch({Key? key}) : super(key: key);

  @override
  _OnlyLlmSearchState createState() => _OnlyLlmSearchState();
}

class _OnlyLlmSearchState extends State<OnlyLlmSearch> {
  final queryController = TextEditingController();
  final LlamaChatWebService llamaService = LlamaChatWebService();

  String responseText = "";
  bool isLoading = false;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    if (!_isListening) {
      _isListening = true;
      llamaService.llmResponseStream.listen((response) {
        setState(() {
          responseText = response;
          isLoading = false;
        });
      });
    }
  }

  @override
  void dispose() {
    queryController.dispose();
    llamaService.dispose();
    super.dispose();
  }

  void handleSend() {
    final query = queryController.text.trim();
    if (query.isEmpty) return;

    setState(() {
      responseText = "";
      isLoading = true;
    });

    llamaService.sendQuery(query);
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double containerWidth = screenWidth < 600 ? screenWidth * 0.8 : 600;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        kIsWeb
            ? Text(
          "Search only with LLM",
          style: GoogleFonts.ibmPlexMono(
            fontSize: 30,
            fontWeight: FontWeight.w400,
            height: 1.2,
            letterSpacing: -0.5,
          ),
        )
            : Text(
          "Search only with LLM",
          style: GoogleFonts.ibmPlexMono(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            height: 1.2,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 32),
        Container(
          width: containerWidth,
          decoration: BoxDecoration(
            color: AppColors.searchBar,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.searchBarBorder,
              width: 1.5,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  controller: queryController,
                  onSubmitted: (_) => handleSend(),
                  decoration: InputDecoration(
                    hintText: "Search anything...",
                    hintStyle: TextStyle(
                      color: AppColors.textGrey,
                      fontSize: 16,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: handleSend,
                      child: Container(
                        padding: const EdgeInsets.all(9),
                        decoration: BoxDecoration(
                          color: AppColors.submitButton,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: const Icon(Icons.arrow_forward, size: 14),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        if (isLoading) const CircularProgressIndicator(),
        if (responseText.isNotEmpty)
          Container(
            width: containerWidth,
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Text(
              responseText,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
      ],
    );
  }
}