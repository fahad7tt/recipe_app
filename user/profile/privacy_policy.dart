import 'package:flutter/material.dart';
import 'package:recipe_app/widget/appbar_widget.dart';
import 'profile.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: CustomAppBar(
        title: 'Privacy Policy',
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
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Effective Date: 20-09-2023\n\n\n',
                    ),
                    TextSpan(
                      text: '1. Introduction\n\n',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        
                      ),
                    ),
                    TextSpan(
                      text:
                          'Welcome to Recipe Book. Protecting your privacy is important to us. This Privacy Policy explains how we collect, use, disclose, and safeguard your personal information when you use our App. By accessing or using the App, you consent to the practices described in this policy.\n\n',
                    ),
                    TextSpan(
                      text: '2. Informations we collect\n\n',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text:
                          '2.1. Information You Provide: We may collect personal information that you voluntarily provide when using the App.\n\n',
                    ),
                    TextSpan(
                      text:
                          '2.2. Recipe Data: When you use the App, we may collect data about your recipe preferences, searches, and saved recipes.\n\n',
                    ),
                    TextSpan(
                      text: '3. How we use your Informations\n\n',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text:
                          '3.1. Provide and Personalize the App: We use your information to provide and personalize the App\'s features, content, and services.\n\n',
                    ),
                    TextSpan(
                      text:
                          '3.2. Analytics: We use analytics tools to better understand how users interact with the App and to improve its functionality and user experience.\n\n',
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
