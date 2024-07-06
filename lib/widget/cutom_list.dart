import 'package:flutter/material.dart';
import 'package:recipe_app/const/color.dart';

class CustomListTile extends StatelessWidget {
  final String subtitle;
  final IconData leadingIcon;
  final IconData trailingIcon;
  final VoidCallback onTap;

  const CustomListTile({
    Key? key,
    required this.subtitle,
    required this.leadingIcon,
    required this.trailingIcon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        subtitle: Container(
          margin: const EdgeInsets.only(top: 9.0),
          child: Row(
            children: [
              Icon(
                leadingIcon,
                color: black,
              ),
              const SizedBox(width: 8),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Color(0xFF3E5481),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Icon(
                trailingIcon,
                color: black,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
