import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_app/admin/admin_guidlines.dart';
import 'package:recipe_app/admin/admin_home.dart';
import 'package:recipe_app/const/color.dart';
import 'package:recipe_app/database/model/recipe_model.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:recipe_app/user/login.dart';

class AppDrawer extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const AppDrawer({Key? key});

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
          return SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  const UserAccountsDrawerHeader(
                    accountName: Text("John Doe"),
                    accountEmail: Text("johndoe@gmail.com"),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: AssetImage("assets/images/logo.png"),
                    ),
                    decoration: BoxDecoration(
                      color: secondaryColor,
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Home'),
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => HomePage(
                          recipes: const [],
                          recipesBox: Hive.box<Recipe>('recipesBox'),
                        ),
                      ));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.description_sharp),
                    title: const Text('Guidelines'),
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const AdminGuidelinesPage(),
                      ));
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
                            content: const Text(
                                'Are you sure you want to sign out?'),
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
                                        child: Text('Signed out successfully'),
                                      ),
                                    ),
                                  );
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => const LoginPage(),
                                    ),
                                  );
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
