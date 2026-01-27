import 'dart:io';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_app/const/color.dart';
import 'package:recipe_app/database/adapter/hive_adapter.dart';
import 'package:recipe_app/database/model/recipe_model.dart';
import 'package:recipe_app/user/users_home.dart';
import 'package:recipe_app/widget/appbar_widget.dart';

class ImagePreviewPage extends StatefulWidget {
  final String sectionTitle;
  final List<String> imageUrls;
  final int initialIndex;
  final String itemName;
  final String duration;
  final String description;
  final String ingredients;

  const ImagePreviewPage({
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
  _ImagePreviewPageState createState() => _ImagePreviewPageState();
}

class _ImagePreviewPageState extends State<ImagePreviewPage> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  int _currentIndex = 0;
  String _currentImageUrl = '';
  String username = '';
  List<String> userReviews = [];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _currentImageUrl = widget.imageUrls[widget.initialIndex];
    _loadUserProfileData();
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
                builder: (context) => UsersHomePage(
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
                        _currentImageUrl = widget.imageUrls[index];
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
