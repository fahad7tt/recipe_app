import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_app/const/color.dart';
import 'package:recipe_app/database/model/recipe_model.dart';
import 'package:recipe_app/user/users_preview.dart';

class RecipeGridView2 extends StatefulWidget {
  final Box<Recipe> recipesBox;
  final List<Recipe> recipes;
  final Function(Recipe, Recipe) updateRecipeInBox;
  final Function(Recipe) removeRecipeFromBox;

  const RecipeGridView2({
    super.key,
    required this.recipesBox,
    required this.recipes,
    required this.updateRecipeInBox,
    required this.removeRecipeFromBox,
  });

  @override
  State<RecipeGridView2> createState() => _RecipeGridView2State();
}

class _RecipeGridView2State extends State<RecipeGridView2> {
  List<bool> isFavoriteList = [];
  List<Recipe> recipes = [];

  @override
  void initState() {
    super.initState();
    // Load recipes from the Hive box when the widget is initialized
    recipes = widget.recipesBox.values.toList();

    isFavoriteList = List.generate(recipes.length, (index) => false);
  }

  void removeRecipeFromFavorites(Recipe recipe) {
  setState(() {
    if (recipe.isFavorite) {
      recipe.isFavorite = false;
      // Update the recipe in the Hive box
      widget.updateRecipeInBox(recipe, recipe);
    }
  });
}

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20.0,
        crossAxisSpacing: 16.0,
      ),
      itemCount: widget.recipes.length,
      itemBuilder: (BuildContext context, int index) {
        if (index < widget.recipes.length) {
          Recipe recipe = widget.recipes[index];

          return ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ImagePreviewPage(
                              sectionTitle: 'Your Section Title',
                              imageUrls: recipe.imageUrls,
                              initialIndex: 0,
                              itemName: recipe.itemName,
                              duration: recipe.duration,
                              description: recipe.description ?? '',
                              ingredients: recipe.ingredients ?? '',
                            ),
                          ),
                        );
                      },
                      child: Image.file(
                        File(recipe.imageUrls.isNotEmpty
                            ? recipe.imageUrls[0]
                            : 'default_image_path.png'),
                        width: 160.0,
                        height: 96.0,
                        fit: BoxFit.fill,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          // Call the function to remove the recipe from favorites
                          removeRecipeFromFavorites(recipe);
                        });
                      },
                      child: Container(
                        width: 25.0,
                        height: 26.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: categoryColor,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Icon(
                          Icons.favorite,
                          size: 13.0,
                          color: isFavoriteList[index] ? primaryColor : red,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      recipe.itemName,
                      style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w800,
                          color: boldTextColor),
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      recipe.category,
                      style: const TextStyle(
                          fontSize: 11.0,
                          color: textColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
