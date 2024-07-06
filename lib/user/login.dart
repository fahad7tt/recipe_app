import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_app/admin/admin_login.dart';
import 'package:recipe_app/const/color.dart';
import 'package:recipe_app/database/adapter/hive_adapter.dart';
import 'package:recipe_app/database/model/recipe_model.dart';
import 'package:recipe_app/user/users_home.dart';
import 'package:recipe_app/widget/common_widgets.dart';
import 'signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Box<Recipe> favoriteBox = Hive.box<Recipe>('favoriteBox');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                  buildLogo(),
                  buildHeader(
                      'Welcome Back', 'Please enter your account details'),
                  buildTextFormField(
                    controller: _emailController,
                    labelText: 'Email',
                    prefixIcon: const Icon(Icons.mail_outline_rounded),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter email';
                      } else if (!RegExp(
                              r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                          .hasMatch(value)) {
                        return 'Invalid email format';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30.0),
                  buildTextFormField(
                    controller: _passwordController,
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock_outline_rounded),
                    isObscureText: _isObscure,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
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
                  const SizedBox(height: 30),
                  buildElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final email = _emailController.text;
                        final password = _passwordController.text;

                        final signupBox =
                            await Hive.openBox<SignupDetails>('signupBox');
                        final signupDetails = signupBox.get('user',
                            defaultValue: SignupDetails(
                                username: '', email: '', password: ''));

                        if (signupDetails != null &&
                            signupDetails.email == email &&
                            signupDetails.password == password) {
                          // Login successful
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UsersHomePage(
                                    recipes: const [],
                                    recipesBox:
                                        Hive.box<Recipe>('recipesBox'))),
                          );
                          // Show the welcome Snackbar
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Center(
                                child: Text('Welcome to Home page'),
                              ),
                            ),
                          );
                        } else {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Invalid email or password'),
                            ),
                          );
                        }
                      }
                    },
                    label: 'Login',
                    buttonColor: secondaryColor,
                    buttonSize: const Size(260.0, 46.0),
                  ),
                  const SizedBox(height: 30.0),
                  RichText(
                    text: TextSpan(
                      text: 'Don’t have an account?       ',
                      style: const TextStyle(
                        fontSize: 15.0,
                        color: Color(0xFF2E3E5C),
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Signup',
                          style: const TextStyle(
                            fontSize: 15.0,
                            color: secondaryColor,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const SignUpPage(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AdminLogin(),
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
                      'Go to Admin Portal',
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
