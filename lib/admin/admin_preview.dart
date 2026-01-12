import 'dart:io';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_app/admin/admin_home.dart';
import 'package:recipe_app/const/color.dart';
import 'package:recipe_app/database/adapter/hive_adapter.dart';
import 'package:recipe_app/database/model/recipe_model.dart';
import 'package:recipe_app/widget/appbar_widget.dart';

class AdminPreviewPage extends StatefulWidget {
  final String sectionTitle;
  final List<String> imageUrls;
  final int initialIndex;
  final String itemName;
  final String duration;
  final String description;
  final String ingredients;

  const AdminPreviewPage({
    super.key,
    required this.sectionTitle,
    required this.imageUrls,
    required this.initialIndex,
    required this.itemName,
    required this.duration,
    required this.description,
    required this.ingredients,
  });

  @override
  // ignore: library_private_types_in_public_api
  _AdminPreviewPageState createState() => _AdminPreviewPageState();
}

class _AdminPreviewPageState extends State<AdminPreviewPage> {
  final CarouselController _carouselController = CarouselController();
  int _currentIndex = 0;
  String _currentImageUrl = '';
  String username = '';
  List<String> userReviews = [];
  String defaultImageUrl = 'assets/default_image.png';

  void _loadUserReviews() async {
    final reviewsBox = await Hive.openBox<List<String>>('userReviews');
    final reviews = reviewsBox.get(widget.itemName, defaultValue: []);

    setState(() {
      userReviews = reviews!;
    });
  }

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _currentImageUrl = widget.imageUrls.isNotEmpty
        ? widget.imageUrls[widget.initialIndex]
        : defaultImageUrl;
    _loadUserProfileData();
    _loadUserReviews(); // Load user reviews when the page is initialized.
  }

  void _loadUserProfileData() async {
    final signupBox = await Hive.openBox<SignupDetails>('signupBox');
    final signupDetails = signupBox.get('user',
        defaultValue: SignupDetails(username: '', email: '', password: ''));
    setState(() {
      username = signupDetails!.username;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.itemName,
        icon: Icons.arrow_back_ios, // Back arrow icon
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(
                  recipes: const [],
                  recipesBox: Hive.box<Recipe>('recipesBox'),
                ),
              ));
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Image Carousel
            Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                CarouselSlider(
                  carouselController: _carouselController,
                  options: CarouselOptions(
                    height: 250.0,
                    aspectRatio: 2.0,
                    enableInfiniteScroll: false,
                    viewportFraction: 1.0,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                        _currentImageUrl = widget.imageUrls.isNotEmpty
                            ? widget.imageUrls[index]
                            : defaultImageUrl;
                      });
                    },
                  ),
                  items: widget.imageUrls.take(5).map((imageUrl) {
                    return Builder(
                      builder: (BuildContext context) {
                        return GestureDetector(
                          child: Image.file(
                            File(_currentImageUrl),
                            width: 360.0,
                            height: 360.0,
                            fit: BoxFit.fill,
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),

                // Add carousel dots
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    widget.imageUrls.take(5).length,
                    (index) {
                      return Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Container(
                          width: 8.0,
                          height: 8.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentIndex == index
                                ? Colors.blue // Active dot color
                                : Colors.grey, // Inactive dot color
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),

            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15.0),
                  const Text(
                    'Duration (mins)',
                    style: TextStyle(
                      color: titleColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(widget.duration,
                      style: const TextStyle(
                          color: black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400)),
                  const SizedBox(height: 18.0),
                  const Divider(
                    thickness: 2,
                  ),
                  const SizedBox(height: 18.0),
                  const Text(
                    'Description',
                    style: TextStyle(
                      color: titleColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(widget.description,
                      style: const TextStyle(
                          color: black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400)),
                  const SizedBox(height: 18.0),
                  const Divider(
                    thickness: 2,
                  ),
                  const SizedBox(height: 18.0),

                  // Ingredients
                  const Text(
                    'Ingredients',
                    style: TextStyle(
                      color: titleColor,
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // List of ingredients with bullet points
                      for (String ingredient in widget.ingredients.split('\n'))
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            children: [
                              const Icon(Icons.brightness_1, size: 8.0),
                              const SizedBox(width: 4.0),
                              Text(
                                ingredient,
                                style: const TextStyle(
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 18.0),
                  const Divider(
                    thickness: 2,
                  ),
                  const SizedBox(height: 18.0),

                  // Review
                  const Text(
                    'User Reviews',
                    style: TextStyle(
                      color: titleColor,
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12.0),

                  // Display user reviews
                  if (userReviews.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          children: userReviews.asMap().entries.map((entry) {
                            final review = entry.value;
                            return ListTile(
                              leading: CircleAvatar(
                                radius: 14,
                                child: Text(username[
                                    0]), // Display the first letter of the username
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top:
                                            16.0), // Adjust the top padding to move the title down
                                    child: Text(username,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16)),
                                  ),
                                  const SizedBox(
                                      height:
                                          13.0), // Add a vertical gap between title and subtitle
                                ],
                              ),
                              subtitle: Text(review),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 0.0,
                                  vertical:
                                      7.0), // Adjust the horizontal padding
                              horizontalTitleGap:
                                  1.0, // Add some gap between title and subtitle
                            );
                          }).toList(),
                        ),
                      ],
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
