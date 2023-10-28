import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_app/database/model/recipe_model.dart';

class DatabaseUtils {
  static void addRecipe(Box<Recipe> recipesBox, Recipe recipe) {
    recipesBox.add(recipe);
  }

  static void updateRecipe(Box<Recipe> recipesBox, Recipe recipe, Recipe newRecipe) {
    int key = recipesBox.keyAt(recipesBox.values.toList().indexOf(recipe));
    if (key != -1) {
      recipesBox.put(key, newRecipe);
    }
  }

  static void removeRecipe(Box<Recipe> recipesBox, Recipe recipe) {
    int key = recipesBox.keyAt(recipesBox.values.toList().indexOf(recipe));
    if (key != -1) {
      recipesBox.delete(key);
    }
  }
}
