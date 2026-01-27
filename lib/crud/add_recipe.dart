import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/const/color.dart';
import 'package:recipe_app/database/model/recipe_model.dart';
import 'package:recipe_app/widget/appbar_widget.dart';
import 'package:recipe_app/widget/common_widgets.dart';

class AddRecipe extends StatefulWidget {
  final Box<Recipe> recipesBox;
  final Function(Recipe) onRecipeAdded;

  const AddRecipe({
    Key? key,
    required this.recipesBox,
    required this.onRecipeAdded,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddRecipeState createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  final TextEditingController itemController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController ingredientsController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String selectedCategory = '';
  final _formKey = GlobalKey<FormState>();
  

  List<XFile> selectedImages = [];
  bool formSubmitted = false;
  List<XFile> pickedImages = [];
  
  Future<void> _selectPhotosFromGallery() async {
    try {
      final pickedImages = await ImagePicker().pickMultiImage();
      if (pickedImages.isNotEmpty) {
        setState(() {
          selectedImages = pickedImages;
        });
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error picking images: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Add Recipe',
        icon: Icons.arrow_back_ios, // Back arrow icon
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: itemController,
                      decoration: const InputDecoration(labelText: 'Item Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an item name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      controller: durationController,
                      decoration: const InputDecoration(labelText: 'Duration (mins)'),
                      keyboardType: TextInputType.number, // Set the keyboardType to number
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a duration';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 35.0),
                    DropdownButtonFormField(
                      value:
                          selectedCategory.isNotEmpty ? selectedCategory : null,
                      items: categories.map((category) {
                        return DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value.toString();
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Category',
                        // Remove the box and use an underline
                        border: const UnderlineInputBorder(),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).primaryColor),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a category';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 25.0),
                    TextFormField(
                      controller: ingredientsController,
                      decoration:
                          const InputDecoration(labelText: 'Ingredients'),
                      maxLines: 5,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter ingredients';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15.0),
                    TextFormField(
                      controller: descriptionController,
                      decoration:
                          const InputDecoration(labelText: 'Description'),
                      maxLines: 5,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 25.0),

                    // Display selected images as previews
                    if (selectedImages.isNotEmpty)
                    selectedImagePreviews(selectedImages),
                    const SizedBox(height: 25.0),
                    ElevatedButton.icon(
                      onPressed: () {
                        _selectPhotosFromGallery();
                      },
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('Upload Photos'),
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(categoryColor),
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (formSubmitted && selectedImages.length < 3)
                      Center(
                        child: Text(
                          'Please upload atleast 3 images',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    const SizedBox(height: 30.0),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          formSubmitted = true;
                        });
                         if (_formKey.currentState!.validate() && selectedImages.length >= 3) {
                            Recipe newRecipe = Recipe(
                              itemName: itemController.text,
                              duration: durationController.text,
                              ingredients: ingredientsController.text,
                              description: descriptionController.text,
                              imageUrls: selectedImages
                                  .map((xFile) => xFile.path)
                                  .toList(),
                              category: selectedCategory,
                            );

                            widget.onRecipeAdded(newRecipe);

                            itemController.clear();
                            durationController.clear();
                            ingredientsController.clear();
                            descriptionController.clear();
                            selectedCategory = '';
                            setState(() {
                              selectedImages.clear();
                              formSubmitted = false;
                            });
                            // Show the success Snackbar
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Center(
                                  // Wrap the Text widget with Center
                                  child: Text('Recipe added successfully'),
                                ),
                              ),
                            );
                            // Close the screen
                            Navigator.pop(context);
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(secondaryColor),
                      ),
                      child: const Text('Add Recipe'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}