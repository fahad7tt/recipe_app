import 'package:flutter/material.dart';
import 'package:recipe_app/const/color.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomFloatingActionButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          onPressed: onPressed,
          backgroundColor: secondaryColor,
          child: const Icon(Icons.add),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
