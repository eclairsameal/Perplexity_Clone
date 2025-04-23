import 'package:flutter/material.dart';
import 'package:perplexity/theme/colors.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      width: 64,
      color: AppColors.sideNav,
      child: Column(
        children: [
          const SizedBox(height: 16),
          Container(
            margin: EdgeInsets.symmetric(vertical: 4),
            child: Icon(
              Icons.auto_awesome_mosaic,
              color: AppColors.whiteColor,
              size: 30,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            margin: EdgeInsets.symmetric(vertical: 4),
            child: Icon(
              Icons.add,
              color: AppColors.whiteColor,
              size: 30,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            margin: EdgeInsets.symmetric(vertical: 4),
            child: Icon(
              Icons.search,
              color: AppColors.whiteColor,
              size: 30,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            margin: EdgeInsets.symmetric(vertical: 4),
            child: Icon(
              Icons.language,
              color: AppColors.whiteColor,
              size: 30,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            margin: EdgeInsets.symmetric(vertical: 4),
            child: Icon(
              Icons.auto_awesome,
              color: AppColors.whiteColor,
              size: 30,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            margin: EdgeInsets.symmetric(vertical: 4),
            child: Icon(
              Icons.cloud_outlined,
              color: AppColors.whiteColor,
              size: 30,
            ),
          ),
          const Spacer(),
          Container(
            margin: EdgeInsets.symmetric(vertical: 4),
            child: Icon(
              Icons.keyboard_arrow_right,
              color: AppColors.whiteColor,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}