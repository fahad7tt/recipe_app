import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_app/const/color.dart';
import 'package:recipe_app/database/adapter/hive_adapter.dart';
import 'package:recipe_app/user/login.dart';
import 'package:recipe_app/widget/common_widgets.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _saveSignupDetails(
      String username, String email, String password) async {
    final signupBox = await Hive.openBox<SignupDetails>('signupBox');
    final signupDetails = SignupDetails(username: '', email: '', password: '')
      ..username = username
      ..email = email
      ..password = password;
    await signupBox.put('user', signupDetails);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildLogo(),
                  buildHeader('Welcome', 'Create a new account'),
                  buildTextFormField(
                    controller: _usernameController,
                    labelText: 'Username',
                    prefixIcon: const Icon(Icons.person_outline_rounded),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a username';
                      }
                      // Auto-capitalize the first letter of the username if needed
                      if (value[0] != value[0].toUpperCase()) {
                        _usernameController.text =
                            value[0].toUpperCase() + value.substring(1);
                      }
                      if (!RegExp(r'^[A-Z][A-Za-z\s]*$')
                          .hasMatch(_usernameController.text)) {
                        return 'Username must start with a capital letter';
                      }
                      // Check for minimum length of 3 characters
                      else if (value.length < 3) {
                        return 'Password must be at least 3 characters long';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30.0),
                  buildTextFormField(
                    controller: _emailController,
                    labelText: 'Email',
                    prefixIcon: const Icon(Icons.mail_outline_rounded),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an email address';
                      } else if (!RegExp(
                              r'^[A-Za-z][A-Za-z0-9._%+-]*@(gmail\.com|outlook\.com|company\.com|inter\.com|hotmail\.com|yahoo\.com)$')
                          .hasMatch(value)) {
                        return 'Invalid email format or domain';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30.0),
                  buildTextFormField(
                    controller: _newPasswordController,
                    labelText: 'New Password',
                    prefixIcon: const Icon(Icons.lock_outline_rounded),
                    isObscureText: _isObscure,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a new password';
                      }
                      // Check for capital letter at the beginning
                      if (!RegExp(r'^[A-Z]').hasMatch(value)) {
                        return 'Password must start with a capital letter';
                      }

                      // Check for at least one special character
                      if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                        return 'Password must contain at least one special character';
                      }

                      // Check for minimum length of 6 characters
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }

                      // Check for at least one number
                      if (!RegExp(r'\d').hasMatch(value)) {
                        return 'Password must contain at least one number';
                      }
                      return null;
                    },
                    onToggleVisibility: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                    showToggleVisibility: true,
                  ),
                  const SizedBox(height: 30.0),
                  buildTextFormField(
                    controller: _passwordController,
                    labelText: 'Confirm Password',
                    prefixIcon: const Icon(Icons.lock_outline_rounded),
                    isObscureText: _isObscure,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please confirm your new password';
                      } else if (value != _newPasswordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    onToggleVisibility: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                    showToggleVisibility: true,
                  ),
                  const SizedBox(height: 30.0),
                  buildElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final username = _usernameController.text;
                        final email = _emailController.text;
                        final password = _passwordController.text;
                        _saveSignupDetails(username, email, password);
                        Navigator.pushReplacementNamed(context, '/login');
                      }
                    },
                    label: 'Sign Up',
                    buttonColor: secondaryColor,
                    buttonSize: const Size(270.0, 46.0),
                  ),
                  const SizedBox(height: 30.0),
                  RichText(
                    text: TextSpan(
                      text: 'Already have an account?       ',
                      style: const TextStyle(
                        fontSize: 15.0,
                        color: Color(0xFF2E3E5C),
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Login',
                          style: const TextStyle(
                            fontSize: 15.0,
                            color: secondaryColor,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                              );
                            },
                        ),
                      ],
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
