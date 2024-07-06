import 'package:flutter/material.dart';
import 'package:recipe_app/const/color.dart';

class CategoryButtons extends StatefulWidget {
  final Function() onAllPressed;
  final Function() onVegPressed;
  final Function() onNonVegPressed;
  final Function() onCurryPressed;
  final Function() onJuicePressed;
  final Function() onNoodlesPressed;
  final Function() onDessertsPressed;
  final Function() onPizzaPressed;
  final Function() onSoupPressed;
  final Function() onOthersPressed;
  final String selectedCategory;

  const CategoryButtons({
    super.key,
    required this.onAllPressed,
    required this.onVegPressed,
    required this.onNonVegPressed,
    required this.onCurryPressed,
    required this.onJuicePressed,
    required this.onNoodlesPressed,
    required this.onDessertsPressed,
    required this.onPizzaPressed,
    required this.onSoupPressed,
    required this.onOthersPressed,
    required this.selectedCategory,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CategoryButtonsState createState() => _CategoryButtonsState();
}

class _CategoryButtonsState extends State<CategoryButtons> {
  List<String> categories = [
    'All',
    'Veg',
    'Non Veg',
    'Curry',
    'Juice',
    'Noodles',
    'Desserts',
    'Pizza',
    'Soup',
    'Others'
  ];
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...categories.map((category) {
            return Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: ElevatedButton(
                onPressed: () {
                  if (category == 'All') {
                    widget.onAllPressed();
                  } else if (category == 'Veg') {
                    widget.onVegPressed();
                  } else if (category == 'Non Veg') {
                    widget.onNonVegPressed();
                  } else if (category == 'Curry') {
                    widget.onCurryPressed();
                  } else if (category == 'Juice') {
                    widget.onJuicePressed();
                  } else if (category == 'Noodles') {
                    widget.onNoodlesPressed();
                  } else if (category == 'Desserts') {
                    widget.onDessertsPressed();
                  } else if (category == 'Pizza') {
                    widget.onPizzaPressed();
                  } else if (category == 'Soup') {
                    widget.onSoupPressed();
                  } else if (category == 'Others') {
                    widget.onOthersPressed();
                  }
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  foregroundColor: widget.selectedCategory == category
                      ? primaryColor
                      : menuColor,
                  backgroundColor: widget.selectedCategory == category
                      ? secondaryColor
                      : plusColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text(category),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
