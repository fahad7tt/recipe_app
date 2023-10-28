import 'dart:io';
import 'package:flutter/material.dart';
import 'package:recipe_app/admin/admin_preview.dart';
import 'package:recipe_app/admin/crud/edit_recipe.dart';
import 'package:recipe_app/const/color.dart';
import 'package:recipe_app/database/model/recipe_model.dart';

class RecipeGridView extends StatelessWidget {
  final List<Recipe> recipes;
  final Function(Recipe, Recipe) updateRecipeInBox;
  final Function(Recipe) removeRecipeFromBox;

  const RecipeGridView({
    super.key,
    required this.recipes,
    required this.updateRecipeInBox,
    required this.removeRecipeFromBox,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20.0,
        crossAxisSpacing: 16.0,
      ),
      itemCount: recipes.length,
      itemBuilder: (BuildContext context, int index) {
        Recipe recipe = recipes[index];

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
                          builder: (context) => AdminPreviewPage(
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
                      File(
                        recipe.imageUrls.isNotEmpty
                            ? recipe.imageUrls[0]
                            : 'default_image_path.png',
                      ),
                      width: 160.0,
                      height: 96.0,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    recipe.itemName,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w800,
                      color: boldTextColor,
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 22.0,
                    child: IconButton(
                      icon: const Icon(
                        Icons.edit,
                        size: 16.0,
                        color: boldTextColor,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditRecipe(
                              recipes: recipes,
                              onRecipeUpdated: (newRecipe) {
                                updateRecipeInBox(recipe, newRecipe);
                              },
                              recipe: recipe,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: 30.0,
                    child: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        size: 16.0,
                        color: red,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Confirm Deletion"),
                              content: const Text(
                                "Are you sure you want to delete this item?",
                              ),
                              actions: [
                                TextButton(
                                  child: const Text("Cancel"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: const Text("Delete"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    // Remove the recipe from the box and update the state
                                    removeRecipeFromBox(recipe);

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Deleted successfully'),
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
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    recipe.category,
                    style: const TextStyle(
                      fontSize: 11.0,
                      color: textColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
