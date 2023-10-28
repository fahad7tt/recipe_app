import 'package:flutter/material.dart';
import 'package:recipe_app/widget/appbar_widget.dart';

import 'profile.dart';

class AppInfo extends StatelessWidget {
  const AppInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: CustomAppBar(
        title: 'App Info',
        icon: Icons.arrow_back_ios, // Back arrow icon
        onPressed: () {
          Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserProfile(),
                ));
        },
      ),
        body: const SingleChildScrollView(
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.all(22.0),
              child: Text(
                'Recipe Booking App is your ultimate cooking companion, designed to make your culinary journey delightful and hassle-free. Whether you\'re a seasoned chef or a beginner in the kitchen, our app has something for everyone. Discover a world of mouthwatering recipes, smart meal planning tools, and cooking inspiration all in one place.\n\n'
                'This app is designed for users who are interested in trying out different varieties of food and are keen in cooking. We provide recipes for various dishes. It is an easy-to-use application.\n\n'
                'Cooking is part of our daily routine, whether you take it for a living or as a hobby. In addition to this, cooking is considered to be the best pass time hobby. Many prefer cooking when stressed, lonely, or want to spend time alone.\n\n'
                'But cooking the same stuff daily can be tedious and frustrating too. Therefore, to make your meal more exciting and tasty, we have brought some of the best cooking recipes you can try right now to learn new recipes.',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
