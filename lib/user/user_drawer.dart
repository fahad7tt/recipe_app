import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_app/const/color.dart';
import 'package:recipe_app/database/adapter/hive_adapter.dart';
import 'package:recipe_app/database/model/recipe_model.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:recipe_app/user/favorite.dart';
import 'package:recipe_app/user/login.dart';
import 'package:recipe_app/user/profile/profile.dart';
import 'package:recipe_app/user/users_home.dart';

class UserDrawer extends StatelessWidget {
  const UserDrawer({super.key});

  Future<PackageInfo> getPackageInfo() async {
    return await PackageInfo.fromPlatform();
  }
  
  @override
  Widget build(BuildContext context) {
     return FutureBuilder<PackageInfo>(
      future: getPackageInfo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); 
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final packageInfo = snapshot.data;
           final signupBox = Hive.box<SignupDetails>('signupBox');
          final signupDetails = signupBox.get('user',
              defaultValue: SignupDetails(username: '', email: '', password: ''));

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
           DrawerHeader(
  decoration: const BoxDecoration(
    color: secondaryColor,
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 10),
      CircleAvatar(
        backgroundColor: ternaryColor,
        radius: 28, // Adjust the radius to your desired size
        child: Text(signupDetails!.username[0],
        style: const TextStyle(
            fontSize: 26, // Adjust the font size here
            fontWeight: FontWeight.w500
          ),),
      ),
      const SizedBox(height: 12.0), // Adjust the height for spacing
      Text(
        signupDetails.username,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 19,
          color: primaryColor
        ),
      ),
      const SizedBox(height: 9.0), 
      Text(
        signupDetails.email,
        style: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 15,
          color: primaryColor
        ),
      ),
    ],
  ),
),

            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => UsersHomePage(
                        recipes: const [],
                        recipesBox: Hive.box<Recipe>('recipesBox'))));
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Favorites'),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => FavoritePage(
                        recipes: const [],
                        recipesBox: Hive.box<Recipe>('recipesBox'))));
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const UserProfile()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout_sharp),
              title: const Text('Sign out'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Sign Out'),
                      content: const Text('Are you sure you want to sign out?'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text('Sign Out'),
                          onPressed: () {
                            // Show the success Snackbar
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Center(
                                  // Wrap the Text widget with Center
                                  child: Text('Signed out successfully'),
                                ),
                              ),
                            );
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()));
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 220),
                  ListTile(
                    subtitle: Center(
                      child: Text(
                        'Version: ${packageInfo?.version}',
                        style: const TextStyle(fontSize: 16.0)),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
  },
  );
}
}
