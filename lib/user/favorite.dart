import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_app/const/color.dart';
import 'package:recipe_app/database/functions/db_functions.dart';
import 'package:recipe_app/database/model/recipe_model.dart';
import 'package:recipe_app/user/user_drawer.dart';
import 'package:recipe_app/widget/appbar_widget.dart';
import 'package:recipe_app/widget/home_widget_copy.dart';

class FavoritePage extends StatefulWidget {
  final Box<Recipe> recipesBox;

  const FavoritePage(
      {Key? key, required this.recipesBox, required List recipes})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  String searchQuery = '';
  List<Recipe> recipes = [];
  List<bool> isFavoriteList = [];
  int currentIndex = 0;
  String selectedCategory = 'All';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // Load recipes from the Hive box when the widget is initialized
    recipes = widget.recipesBox.values.toList();

    isFavoriteList = List.generate(recipes.length, (index) => false);
  }
  void updateSelectedCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }
  void updateRecipeInBox(Recipe recipe, Recipe newRecipe) {
    int index = recipes.indexOf(recipe);
    if (index != -1) {
      setState(() {
        recipes[index] = newRecipe;
      });
      DatabaseUtils.updateRecipe(widget.recipesBox, recipe, newRecipe);
    }
  }
  void removeRecipeFromBox(Recipe recipe) {
    setState(() {
      recipes.remove(recipe);
    });
    DatabaseUtils.removeRecipe(widget.recipesBox, recipe);
  }

  List<Recipe> getFilteredFavoriteRecipes() {
    return recipes.where((recipe) {
      return recipe.isFavorite &&
          (selectedCategory == 'All' || recipe.category == selectedCategory);
    }).toList();
  }

  List<Recipe> getFilteredFavoriteRecipesByFirstLetter() {
    return getFilteredFavoriteRecipes().where((recipe) {
      final itemName = recipe.itemName.toLowerCase();
      return recipe.isFavorite &&
          (selectedCategory == 'All' || recipe.category == selectedCategory) &&
          (searchQuery.isEmpty ||
              itemName.startsWith(searchQuery.toLowerCase()));
    }).toList();
  }

  void removeRecipeFromFavorites(Recipe recipe) {
  setState(() {
    if (recipe.isFavorite) {
      recipe.isFavorite = false;
      // Update the recipe in the Hive box
      updateRecipeInBox(recipe, recipe);
    }
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Favorites',
        icon: Icons.menu,
        onPressed: () {
          _scaffoldKey.currentState!.openDrawer();
        },
      ),
      key: _scaffoldKey,
      backgroundColor: primaryColor,
      drawer: const UserDrawer(),
      body: HomeBody1(
        searchQuery: searchQuery,
        recipes: recipes,
        selectedCategory: selectedCategory,
        onSearchQueryChanged: (value) {
          setState(() {
            searchQuery = value;
          });
        },
        onCategorySelected: (category) {
          setState(() {
            selectedCategory = category;
          });
        },
        getFilteredUserRecipesByFirstLetter:
            getFilteredFavoriteRecipesByFirstLetter,
        updateRecipeInBox: updateRecipeInBox,
        removeRecipeFromBox: removeRecipeFromBox,
      ),
    );
  }
}