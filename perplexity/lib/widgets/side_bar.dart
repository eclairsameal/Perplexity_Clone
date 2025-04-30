import 'package:flutter/material.dart';
import 'package:perplexity/theme/colors.dart';
import 'package:perplexity/widgets/side_bar_button.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  bool isCollapsed = true; // 是否折疊SideBar

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      // 動畫元件，用來平滑過渡某些屬性的改變
      duration: const Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(vertical: 20),
      width: isCollapsed ? 64 : 140, // 依照isCollapsed切換SideBar的寬度
      color: AppColors.sideNav,
      child: Column(
        children: [
          const SizedBox(height: 16),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Icon(Icons.auto_awesome_mosaic, color: AppColors.whiteColor, size: isCollapsed ? 30 : 60),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: isCollapsed ? CrossAxisAlignment.center : CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                SideBarButton(isCollapsed: isCollapsed, icon: Icons.add, text: "Home"),

                const SizedBox(height: 16),
                SideBarButton(isCollapsed: isCollapsed, icon: Icons.search, text: "Search"),

                const SizedBox(height: 16),
                SideBarButton(isCollapsed: isCollapsed, icon: Icons.language, text: "Spaces"),

                const SizedBox(height: 16),
                SideBarButton(isCollapsed: isCollapsed, icon: Icons.auto_awesome, text: "Discover"),

                const SizedBox(height: 16),
                SideBarButton(isCollapsed: isCollapsed, icon: Icons.cloud_outlined, text: "Library"),

                const Spacer(),
              ],
            ),
          ),
          GestureDetector(
            // 偵測使用者互動
            onTap: () {
              // 點擊（tap） 事件
              setState(() {
                // 通知框架， 內部的變數變化，會觸發 Flutter 的畫面更新。
                isCollapsed = !isCollapsed; // 切換 isCollapsed 的布林值
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Icon(
                isCollapsed ? Icons.keyboard_arrow_right : Icons.keyboard_arrow_left, // 縮放時變換箭頭方向
                color: AppColors.whiteColor,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
