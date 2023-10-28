import 'package:flutter/material.dart';
import 'package:recipe_app/categories/category_selection.dart';
import 'package:recipe_app/const/color.dart';
import 'package:recipe_app/database/model/recipe_model.dart';
import 'package:recipe_app/widget/recipe_grid_copy.dart';
import 'package:recipe_app/widget/search.dart';

class HomeBody1 extends StatelessWidget {
  final String searchQuery;
  final List<Recipe> recipes;
  final String selectedCategory;
  final Function(String) onSearchQueryChanged;
  final Function(String) onCategorySelected;
  final List<Recipe> Function() getFilteredUserRecipesByFirstLetter;
  final Function(Recipe, Recipe) updateRecipeInBox;
  final Function(Recipe) removeRecipeFromBox;

  const HomeBody1({super.key, 
    required this.searchQuery,
    required this.recipes,
    required this.selectedCategory,
    required this.onSearchQueryChanged,
    required this.onCategorySelected,
    required this.getFilteredUserRecipesByFirstLetter,
    required this.updateRecipeInBox,
    required this.removeRecipeFromBox,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          buildSearchBar(searchQuery, onSearchQueryChanged),
          const SizedBox(height: 15),
          const Padding(
            padding: EdgeInsets.only(left: 20.0, top: 18.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Category',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: ternaryColor,
                ),
              ),
            ),
          ),
          CategorySelection(
            selectedCategory: selectedCategory,
            onCategorySelected: onCategorySelected,
          ),
          const SizedBox(height: 5),
          const Divider(
            thickness: 5,
            color: dividerColor,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 3, right: 3),
              child: getFilteredUserRecipesByFirstLetter().isEmpty
                  ? const Center(
                      child: Text(
                        'No items found',
                        style: TextStyle(fontSize: 16, color: textColor),
                      ),
                    )
                  : RecipeGridView1(
                      recipes: getFilteredUserRecipesByFirstLetter(),
                      updateRecipeInBox: updateRecipeInBox,
                      removeRecipeFromBox: removeRecipeFromBox,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}