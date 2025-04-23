import 'package:flutter/material.dart';
import 'package:perplexity/theme/colors.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  bool isCollapsed = true;  // 是否折疊SideBar

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(    // 動畫元件，用來平滑過渡某些屬性的改變
      duration: const Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(vertical: 20),
      width: isCollapsed ? 64 : 128,   // 依照isCollapsed切換SideBar的寬度
      color: AppColors.sideNav,
      child: Column(
        crossAxisAlignment: isCollapsed ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Icon(
              Icons.auto_awesome_mosaic,
              color: AppColors.whiteColor,
              size: 30,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: isCollapsed ? MainAxisAlignment.center : MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Icon(
                  Icons.add,
                  color: AppColors.whiteColor,
                  size: 30,
                ),
              ),
              isCollapsed
                  ? const SizedBox()
                  : Text(
                    "Home",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                  ),
                )
            ],
          ),
          const SizedBox(height: 16),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Icon(
              Icons.search,
              color: AppColors.whiteColor,
              size: 30,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Icon(
              Icons.language,
              color: AppColors.whiteColor,
              size: 30,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Icon(
              Icons.auto_awesome,
              color: AppColors.whiteColor,
              size: 30,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Icon(
              Icons.cloud_outlined,
              color: AppColors.whiteColor,
              size: 30,
            ),
          ),
          const Spacer(),
          GestureDetector( // 偵測使用者互動
            onTap: () {    // 點擊（tap） 事件
              setState(() {  // 通知框架， 內部的變數變化，會觸發 Flutter 的畫面更新。
                isCollapsed = !isCollapsed;  // 切換 isCollapsed 的布林值
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Icon(
                isCollapsed ? Icons.keyboard_arrow_right : Icons.keyboard_arrow_left,    // 縮放時變換箭頭方向
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