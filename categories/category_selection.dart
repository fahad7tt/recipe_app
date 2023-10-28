import 'package:flutter/material.dart';
import 'package:recipe_app/categories/category_buttons.dart';

class CategorySelection extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const CategorySelection({super.key, 
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  CategoryButtons(
                    onAllPressed: () {
                      onCategorySelected('All');
                    },
                    onVegPressed: () {
                      onCategorySelected('Veg');
                    },
                    onNonVegPressed: () {
                      onCategorySelected('Non Veg');
                    },
                    onCurryPressed: () {
                      onCategorySelected('Curry');
                    },
                    onJuicePressed: () {
                      onCategorySelected('Juice');
                    },
                    onNoodlesPressed: () {
                      onCategorySelected('Noodles');
                    },
                    onDessertsPressed: () {
                      onCategorySelected('Desserts');
                    },
                    onPizzaPressed: () {
                      onCategorySelected('Pizza');
                    },
                    onSoupPressed: () {
                      onCategorySelected('Soup');
                    },
                    onOthersPressed: () {
                      onCategorySelected('Others');
                    },
                    selectedCategory: selectedCategory,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
