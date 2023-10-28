import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_app/admin/admin_home.dart';
import 'package:recipe_app/const/color.dart';
import 'package:recipe_app/database/model/recipe_model.dart';
import 'package:recipe_app/widget/appbar_widget.dart';

class AdminGuidelinesPage extends StatelessWidget {
  const AdminGuidelinesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: CustomAppBar(
        title: 'Guidelines',
        icon: Icons.arrow_back_ios, // Back arrow icon
        onPressed: () {
          Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(
                    recipes: const [],
                    recipesBox: Hive.box<Recipe>('recipesBox'),
                  ),
                ));
        },
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          '''

  • Maintain a high standard of user conduct.\n
  • Monitor and moderate user-generated \u00A0\u00A0\u00A0\u00A0\u00A0content.\n
  • Respond to user inquiries and requests in \u00A0\u00A0\u00A0\u00A0 a timely manner.\n
  • Ensure the security and integrity of the \u00A0\u00A0\u00A0\u00A0\u00A0platform.\n
  • Enforce the terms of service and policies.\n


  These are the general guidelines for the \u00A0\u00A0administrators. Please follow the guidelines \u00A0\u00A0diligently to maintain a very safe and \u00A0\u00A0productive environment.
  ''',
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}
