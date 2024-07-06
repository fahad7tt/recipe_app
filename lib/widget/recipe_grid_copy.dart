import 'dart:io';
import 'package:flutter/material.dart';
import 'package:recipe_app/const/color.dart';
import 'package:recipe_app/database/model/recipe_model.dart';
import 'package:recipe_app/user/users_preview.dart';

class RecipeGridView1 extends StatefulWidget {
  final List<Recipe> recipes;
  final Function(Recipe, Recipe) updateRecipeInBox;
  final Function(Recipe) removeRecipeFromBox;

  const RecipeGridView1({
    super.key,
    required this.recipes,
    required this.updateRecipeInBox,
    required this.removeRecipeFromBox,
  });

  @override
  State<RecipeGridView1> createState() => _RecipeGridView1State();
}

class _RecipeGridView1State extends State<RecipeGridView1> {
  List<bool> isFavoriteList = [];

  @override
  void initState() {
    super.initState();
    // Initialize isFavoriteList with the same number of elements as recipes
    isFavoriteList = List.filled(widget.recipes.length, false);
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
                          isFavoriteList[index] = !isFavoriteList[index];
                          // Update the isFavorite property of the recipe
                          recipe.isFavorite = isFavoriteList[index];
                          // Save the updated recipe to Hive
                          widget.updateRecipeInBox(recipe, recipe);
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
                          color: recipe.isFavorite ? red : primaryColor,
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
