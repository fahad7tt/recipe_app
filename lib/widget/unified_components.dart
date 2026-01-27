import 'dart:io';
import 'package:flutter/material.dart';
import 'package:recipe_app/crud/edit_recipe.dart';
import 'package:recipe_app/user/users_preview.dart';
import 'package:recipe_app/categories/category_selection.dart';
import 'package:recipe_app/const/color.dart';
import 'package:recipe_app/database/model/recipe_model.dart';
import 'package:recipe_app/widget/search.dart';

class EmptyStateWidget extends StatelessWidget {
  final String title;
  final String message;

  const EmptyStateWidget({
    super.key,
    this.title = 'No Recipes Yet',
    this.message = 'Start adding some delicious recipes or explore categories!',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/empty_state.png',
              height: 200,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.restaurant_menu,
                size: 80,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: boldTextColor,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UnifiedRecipeGrid extends StatefulWidget {
  final List<Recipe> recipes;
  final bool isAdmin;
  final Function(Recipe, Recipe) updateRecipeInBox;
  final Function(Recipe) removeRecipeFromBox;

  const UnifiedRecipeGrid({
    super.key,
    required this.recipes,
    required this.isAdmin,
    required this.updateRecipeInBox,
    required this.removeRecipeFromBox,
  });

  @override
  State<UnifiedRecipeGrid> createState() => _UnifiedRecipeGridState();
}

class _UnifiedRecipeGridState extends State<UnifiedRecipeGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20.0,
        crossAxisSpacing: 16.0,
        childAspectRatio: 0.75,
      ),
      itemCount: widget.recipes.length,
      itemBuilder: (BuildContext context, int index) {
        Recipe recipe = widget.recipes[index];

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
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
                              sectionTitle: recipe.category,
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
                      child: Hero(
                        tag: 'recipe_${recipe.itemName}_$index',
                        child: Image.file(
                          File(recipe.imageUrls.isNotEmpty
                              ? recipe.imageUrls[0]
                              : 'assets/images/placeholder.png'),
                          width: double.infinity,
                          height: 100.0,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            height: 100,
                            color: Colors.grey[200],
                            child: const Icon(Icons.broken_image),
                          ),
                        ),
                      ),
                    ),
                    if (!widget.isAdmin)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              recipe.isFavorite = !recipe.isFavorite;
                              widget.updateRecipeInBox(recipe, recipe);
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Icon(
                              Icons.favorite,
                              size: 18.0,
                              color: recipe.isFavorite ? red : Colors.grey[300],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          recipe.itemName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: boldTextColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          recipe.category,
                          style: const TextStyle(
                            fontSize: 11.0,
                            color: textColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        if (widget.isAdmin)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                constraints: const BoxConstraints(),
                                padding: EdgeInsets.zero,
                                icon: const Icon(Icons.edit,
                                    size: 18, color: Colors.blue),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditRecipe(
                                        recipes: widget.recipes,
                                        onRecipeUpdated: (newRecipe) {
                                          widget.updateRecipeInBox(
                                              recipe, newRecipe);
                                        },
                                        recipe: recipe,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(width: 8),
                              IconButton(
                                constraints: const BoxConstraints(),
                                padding: EdgeInsets.zero,
                                icon: const Icon(Icons.delete,
                                    size: 18, color: Colors.red),
                                onPressed: () {
                                  _showDeleteConfirmation(context, recipe);
                                },
                              ),
                            ],
                          )
                        else
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                const Icon(Icons.timer_outlined,
                                    size: 12, color: textColor),
                                const SizedBox(width: 4),
                                Text(
                                  '${recipe.duration} mins',
                                  style: const TextStyle(
                                      fontSize: 11, color: textColor),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showDeleteConfirmation(BuildContext context, Recipe recipe) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: const Text("Confirm Deletion"),
          content: const Text(
              "Are you sure you want to delete this delicious recipe?"),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop();
                widget.removeRecipeFromBox(recipe);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Recipe removed')),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class UnifiedHomeBody extends StatelessWidget {
  final String searchQuery;
  final List<Recipe> recipes;
  final String selectedCategory;
  final bool isAdmin;
  final Function(String) onSearchQueryChanged;
  final Function(String) onCategorySelected;
  final List<Recipe> Function() getFilteredRecipes;
  final Function(Recipe, Recipe) updateRecipeInBox;
  final Function(Recipe) removeRecipeFromBox;

  const UnifiedHomeBody({
    super.key,
    required this.searchQuery,
    required this.recipes,
    required this.selectedCategory,
    required this.isAdmin,
    required this.onSearchQueryChanged,
    required this.onCategorySelected,
    required this.getFilteredRecipes,
    required this.updateRecipeInBox,
    required this.removeRecipeFromBox,
  });

  @override
  Widget build(BuildContext context) {
    final filteredRecipes = getFilteredRecipes();

    return Column(
      children: [
        buildSearchBar(searchQuery, onSearchQueryChanged),
        const SizedBox(height: 15),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
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
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Divider(thickness: 1, color: dividerColor),
        ),
        Expanded(
          child: filteredRecipes.isEmpty
              ? EmptyStateWidget(
                  title: searchQuery.isNotEmpty
                      ? 'No matches found'
                      : 'Empty Recipe Book',
                  message: searchQuery.isNotEmpty
                      ? 'Try searching for something else!'
                      : isAdmin
                          ? 'Tap the + button to add your first recipe!'
                          : 'Admin is cooking something up. Check back later!',
                )
              : UnifiedRecipeGrid(
                  recipes: filteredRecipes,
                  isAdmin: isAdmin,
                  updateRecipeInBox: updateRecipeInBox,
                  removeRecipeFromBox: removeRecipeFromBox,
                ),
        ),
      ],
    );
  }
}
