import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_app/admin/admin_home.dart';
import 'package:recipe_app/const/color.dart';
import 'package:recipe_app/database/model/recipe_model.dart';
import 'package:recipe_app/user/login.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isObscure = true;

  final TextEditingController _adminemailController = TextEditingController();
  final TextEditingController _adminpasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 100.0,
                      height: 100.0,
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  const Text(
                    'Admin Portal',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: boldTextColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40.0),
                  Column(
                    children: [
                      TextFormField(
                        controller: _adminemailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: const Icon(Icons.mail_outline_rounded),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          contentPadding: const EdgeInsets.all(10.0),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30.0),
                      TextFormField(
                        obscureText: _isObscure,
                        controller: _adminpasswordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock_outline_rounded),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                            child: Icon(
                              _isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          contentPadding: const EdgeInsets.all(10.0),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 30.0),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final adminEmail = _adminemailController.text;
                        final adminPassword = _adminpasswordController.text;

                        const predefinedUsername = "admin@example.com";
                        const predefinedPassword = "Admin123";

                        if (adminEmail == predefinedUsername &&
                            adminPassword == predefinedPassword) {
                          Navigator.pop(context);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage(
                                    recipes: const [],
                                    recipesBox:
                                        Hive.box<Recipe>('recipesBox'))),
                          );
                          // Show the success Snackbar
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Center(
                                // Wrap the Text widget with Center
                                child: Text('Welcome to Admin page'),
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Invalid username or password'),
                            ),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: secondaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                    ).copyWith(
                      fixedSize: WidgetStateProperty.all(
                        const Size(260.0, 46.0),
                      ),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 160.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: secondaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ).copyWith(
                      fixedSize: WidgetStateProperty.all(
                        const Size(180.0, 44.0),
                      ),
                    ),
                    child: const Text(
                      'Back to User Login',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
