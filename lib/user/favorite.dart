import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_app/const/color.dart';
import 'package:recipe_app/database/functions/db_functions.dart';
import 'package:recipe_app/database/model/recipe_model.dart';
import 'package:recipe_app/user/user_drawer.dart';
import 'package:recipe_app/widget/appbar_widget.dart';
import 'package:recipe_app/widget/unified_components.dart';

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
  String selectedCategory = 'All';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  void _loadRecipes() {
    setState(() {
      recipes = widget.recipesBox.values.toList();
    });
  }

  void updateRecipeInBox(Recipe recipe, Recipe newRecipe) {
    int index = recipes.indexOf(recipe);
    if (index != -1) {
      DatabaseUtils.updateRecipe(widget.recipesBox, recipe, newRecipe);
      _loadRecipes();
    }
  }

  void removeRecipeFromBox(Recipe recipe) {
    DatabaseUtils.removeRecipe(widget.recipesBox, recipe);
    _loadRecipes();
  }

  List<Recipe> getFilteredRecipes() {
    return recipes.where((recipe) {
      if (!recipe.isFavorite) return false;
      final itemName = recipe.itemName.toLowerCase();
      final matchesCategory =
          selectedCategory == 'All' || recipe.category == selectedCategory;
      final matchesSearch =
          searchQuery.isEmpty || itemName.contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Favorites',
        icon: Icons.menu,
        onPressed: () => _scaffoldKey.currentState!.openDrawer(),
      ),
      key: _scaffoldKey,
      backgroundColor: primaryColor,
      drawer: const UserDrawer(),
      body: UnifiedHomeBody(
        searchQuery: searchQuery,
        recipes: recipes,
        selectedCategory: selectedCategory,
        isAdmin: false,
        onSearchQueryChanged: (value) => setState(() => searchQuery = value),
        onCategorySelected: (category) =>
            setState(() => selectedCategory = category),
        getFilteredRecipes: getFilteredRecipes,
        updateRecipeInBox: updateRecipeInBox,
        removeRecipeFromBox: removeRecipeFromBox,
      ),
    );
  }
}
