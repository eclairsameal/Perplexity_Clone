import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perplexity/theme/colors.dart';
import 'package:perplexity/widgets/search_bar_button.dart';

class SearchSection extends StatelessWidget {
  const SearchSection({super.key});


  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    // 寬度根據螢幕大小調整：手機佔80%，桌面上限600
    final double containerWidth = screenWidth < 600
        ? screenWidth * 0.8
        : 600;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
            "Where knowledge begins",
            style: GoogleFonts.ibmPlexMono(
                fontSize: 16,
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
                    SearchBarButton(
                      icon: Icons.auto_awesome_outlined,
                      text: "Focus",
                    ),
                    const SizedBox(width: 10),
                    SearchBarButton(
                      icon: Icons.add_circle_outline_outlined,
                      text: "Attach",
                    ),
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        color: AppColors.submitButton,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: const Icon(Icons.arrow_forward, size: 14),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
