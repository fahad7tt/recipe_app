import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_app/admin/admin_drawer.dart';
import 'package:recipe_app/admin/crud/add_recipe.dart';
import 'package:recipe_app/const/color.dart';
import 'package:recipe_app/database/functions/db_functions.dart';
import 'package:recipe_app/database/model/recipe_model.dart';
import 'package:recipe_app/widget/appbar_widget.dart';
import 'package:recipe_app/widget/floating_action_button.dart';
import 'package:recipe_app/widget/home_widget.dart';

class HomePage extends StatefulWidget {
  final Box<Recipe> recipesBox;

  const HomePage({Key? key, required this.recipesBox, required List recipes})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchQuery = '';
  List<Recipe> recipes = [];
  int currentIndex = 0;
  String selectedCategory = 'All';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int homeIndex=0;

  @override
  void initState() {
    super.initState();
    recipes = widget.recipesBox.values.toList();
  }

  void addRecipe(Recipe recipe) {
    setState(() {
      recipes.add(recipe);
      DatabaseUtils.addRecipe(widget.recipesBox, recipe);
    });
  }
void home(index) {
    setState(() {
      homeIndex=index;
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

  void updateSelectedCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  List<Recipe> getFilteredUserRecipesByFirstLetter() {
    return recipes.where((recipe) {
      final itemName = recipe.itemName.toLowerCase();
      return (selectedCategory == 'All' || recipe.category == selectedCategory) &&
          (searchQuery.isEmpty || itemName.startsWith(searchQuery.toLowerCase()));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Recipe Book',
        icon: Icons.menu,
        onPressed: () {
          _scaffoldKey.currentState!.openDrawer();
        },
      ),
      key: _scaffoldKey,
      backgroundColor: primaryColor,
      drawer: const AppDrawer(),
      body: HomeBody(
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
        getFilteredUserRecipesByFirstLetter: getFilteredUserRecipesByFirstLetter,
        updateRecipeInBox: updateRecipeInBox,
        removeRecipeFromBox: removeRecipeFromBox,
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddRecipe(
                onRecipeAdded: (newRecipe) {
                  setState(() {
                    widget.recipesBox.add(newRecipe);
                    recipes.add(newRecipe);
                  });
                },
                recipesBox: Hive.box<Recipe>('recipesBox'),
              ),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}