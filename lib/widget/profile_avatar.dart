import 'package:flutter/material.dart';
import 'package:recipe_app/const/color.dart';

class UserProfileAvatar extends StatelessWidget {
  final String username;

  const UserProfileAvatar({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const CircleAvatar(
          radius: 34,
          backgroundColor: ternaryColor,
        ),
        Text(
          username.isNotEmpty ? username[0] : '',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 32,
          ),
        ),
      ],
    );
  }
}
