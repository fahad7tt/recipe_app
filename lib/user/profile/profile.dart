import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_app/const/color.dart';
import 'package:recipe_app/database/adapter/hive_adapter.dart';
import 'package:recipe_app/database/model/recipe_model.dart';
import 'package:recipe_app/user/login.dart';
import 'package:recipe_app/user/profile/privacy_policy.dart';
import 'package:recipe_app/user/users_home.dart';
import 'package:recipe_app/widget/appbar_widget.dart';
import 'package:recipe_app/widget/cutom_list.dart';
import 'package:recipe_app/widget/profile_avatar.dart';
import 'package:recipe_app/widget/profile_text.dart';
import 'app_info.dart';
import 'terms.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String username = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    _loadUserProfileData();
  }

  void _loadUserProfileData() async {
    final signupBox = await Hive.openBox<SignupDetails>('signupBox');
    final signupDetails = signupBox.get('user',
        defaultValue: SignupDetails(username: '', email: '', password: ''));

    setState(() {
      username = signupDetails!.username;
      email = signupDetails.email;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Profile',
        icon: Icons.arrow_back_ios,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UsersHomePage(
                recipes: const [],
                recipesBox: Hive.box<Recipe>('recipesBox'),
              ),
            ),
          );
        },
      ),
      body: ListView(
        padding: const EdgeInsets.all(12.0),
        children: <Widget>[
          const SizedBox(height: 18),
          UserProfileAvatar(username: username),
          const SizedBox(height: 13),
          UserProfileText(text: username, color: boldTextColor, fontSize: 18, fontWeight: FontWeight.w600),
          const SizedBox(height: 8),
          UserProfileText(text: email, color: textColor, fontSize: 13, fontWeight: FontWeight.w400),
          const SizedBox(height: 30),
          CustomListTile(
            subtitle: 'App info',
            leadingIcon: Icons.info,
            trailingIcon: Icons.arrow_forward_ios,
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AppInfo()));
            },
          ),
          CustomListTile(
            subtitle: 'Privacy policy',
            leadingIcon: Icons.lock_rounded,
            trailingIcon: Icons.arrow_forward_ios,
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const PrivacyPolicy()));
            },
          ),
          CustomListTile(
            subtitle: 'Terms and conditions',
            leadingIcon: Icons.file_copy,
            trailingIcon: Icons.arrow_forward_ios,
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Terms()));
            },
          ),
          CustomListTile(
            subtitle: 'Sign out',
            leadingIcon: Icons.logout_outlined,
            trailingIcon: Icons.arrow_forward_ios,
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Sign Out"),
                    content: const Text("Are you sure you want to sign out?"),
                    actions: [
                      TextButton(
                        child: const Text("Cancel"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text("Sign Out"),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
