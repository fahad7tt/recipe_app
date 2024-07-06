import 'package:hive_flutter/hive_flutter.dart';

part 'recipe_model.g.dart';

@HiveType(typeId: 2)
class Recipe {
  @HiveField(0)
  final String itemName;
  @HiveField(1)
  final String duration;
  @HiveField(2)
  final String? ingredients;
  @HiveField(3)
  final String? description;
  @HiveField(4)
  final List<String> imageUrls;
  @HiveField(5)
  final String category;
  @HiveField(6)
  bool isFavorite;
   @HiveField(7)
  List<String> userReviews;
  Recipe({
    required this.itemName,
    required this.duration,
    this.ingredients,
    this.description,
    required this.imageUrls,
    required this.category,
    this.isFavorite = false,
    this.userReviews = const [],
  });

  void toggleFavorite() {
    isFavorite = !isFavorite;
  }
}
