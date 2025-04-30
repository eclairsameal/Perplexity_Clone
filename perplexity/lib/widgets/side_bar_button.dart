import 'package:flutter/material.dart';
import '../theme/colors.dart';

class SideBarButton extends StatelessWidget {
  final bool isCollapsed;
  final IconData icon;
  final String text;
  const SideBarButton({super.key, required this.isCollapsed, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isCollapsed ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Icon(icon, color: AppColors.whiteColor, size: 20),
        ),
        if (!isCollapsed)
          Flexible(
            // 避免在 SideBar 展開時因文字太寬導致的 RenderFlex overflow 問題
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
      ],
    );
  }
}
