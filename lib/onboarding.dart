import 'package:flutter/material.dart';
import 'package:recipe_app/const/color.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
      child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 360.0,
            height: 420.0,
            child: Image.asset(
              'assets/images/onboarding.png',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 50.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Let’s Cook',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: boldTextColor,
                  ),
                ),
              ),
              const SizedBox(height: 25.0),
              const Text(
                'Join our community\nto cook better food!',
                style: TextStyle(
                  fontSize: 17.0,
                  color: foregroundColor,
                ),
              ),
              const SizedBox(height: 60.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/login');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                ).copyWith(
                  fixedSize: WidgetStateProperty.all(
                    const Size(280.0, 50.0),
                  ),
                ),
                child: const Text(
                  'Get Started',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      ),
      ),
    );
  }
}
