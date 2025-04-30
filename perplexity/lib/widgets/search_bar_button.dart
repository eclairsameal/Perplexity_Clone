import 'package:flutter/material.dart';
import 'package:perplexity/theme/colors.dart';

class SearchBarButton extends StatefulWidget {
  final IconData icon;
  final String text;
  const SearchBarButton({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  _SearchBarButtonState createState() => _SearchBarButtonState();
}

class _SearchBarButtonState extends State<SearchBarButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color:Colors.transparent,
      ),
      child: Row(
        children: [
          Icon(
            //Icons.plus_one,
            widget.icon,
            color: AppColors.iconGrey,
            size: 20,
          ),
          const SizedBox(width: 4),
          Text(
            //"Focus",
            widget.text,
            style: TextStyle(
                color: AppColors.textGrey
            ),
          )
        ],
      ),
    );
  }
}
