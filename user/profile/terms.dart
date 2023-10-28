import 'package:flutter/material.dart';
import 'package:recipe_app/const/color.dart';
import 'package:recipe_app/widget/appbar_widget.dart';
import 'profile.dart';

class Terms extends StatelessWidget {
  const Terms({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: CustomAppBar(
        title: 'Terms and Conditions',
        icon: Icons.arrow_back_ios, // Back arrow icon
        onPressed: () {
          Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserProfile(),
                ));
        },
      ),
        body: SingleChildScrollView(
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 17,
                    color: black,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text:
                          'Please read these Terms and Conditions carefully before using this app :\n\n\n',
                    ),
                    TextSpan(
                      text: '1. Acceptance of Terms\n\n',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text:
                          'By accessing or using the App, you agree to comply with and be bound by these Terms.\n\n',
                    ),
                    TextSpan(
                      text: '2. Changes to Terms\n\n',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text:
                          'We reserve the right to modify or replace these Terms at any time without prior notice. The most current version of these Terms will be posted on the App.\n\n',
                    ),
                    TextSpan(
                      text: '3. Use of the App\n\n',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text:
                          'a. You must be at least 18 years old to use the App.\n\n',
                    ),
                    TextSpan(
                      text:
                          'b. You are responsible for maintaining the security and confidentiality of your account login information.\n\n',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
