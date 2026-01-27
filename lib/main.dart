import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_app/user/users_home.dart';
import 'package:recipe_app/database/adapter/hive_adapter.dart';
import 'package:recipe_app/database/model/recipe_model.dart';
import 'package:recipe_app/onboarding.dart';
import 'package:recipe_app/user/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapter(SignupDetailsAdapter());
  Hive.registerAdapter(RecipeAdapter());

  await Hive.initFlutter();
  await Hive.openBox<SignupDetails>('signupBox');
  await Hive.openBox<Recipe>('recipesBox');
  await Hive.openBox<Recipe>('favoriteBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/second',
      routes: {
        '/second': (context) => const OnBoarding(),
        '/login': (context) => const LoginPage(),
        '/home': (context) => UsersHomePage(
            recipes: const [], recipesBox: Hive.box<Recipe>('recipesBox')),
        '/all': (context) => UsersHomePage(
            recipes: const [], recipesBox: Hive.box<Recipe>('recipesBox')),
      },
    );
  }
}
