import 'package:flutter/material.dart';
import 'package:recipe_app/const/color.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconData icon;
  final Function() onPressed;

  const CustomAppBar({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: primaryColor,
      elevation: 4,
      leading: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: icon == Icons.arrow_back_ios ? black : menuColor, size: icon == Icons.arrow_back_ios ? 18 : 29),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: boldTextColor,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      centerTitle: true,
      toolbarHeight: 60.0,
    );
  }
}
