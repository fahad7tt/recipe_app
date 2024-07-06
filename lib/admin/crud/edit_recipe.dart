import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/const/color.dart';
import 'package:recipe_app/database/model/recipe_model.dart';
import 'package:recipe_app/widget/appbar_widget.dart';
import 'package:recipe_app/widget/common_widgets.dart';

class EditRecipe extends StatefulWidget {
  final List<Recipe> recipes;
  final Function(Recipe) onRecipeUpdated;
  final Recipe recipe;

  const EditRecipe({
    Key? key,
    required this.recipes,
    required this.onRecipeUpdated,
    required this.recipe,
    String? category,
    List<XFile>? images,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EditRecipeState createState() => _EditRecipeState();
}

class _EditRecipeState extends State<EditRecipe> {
  final _formKey = GlobalKey<FormState>();

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
  void initState() {
    super.initState();
    itemController.text = widget.recipe.itemName;
    durationController.text = widget.recipe.duration;
    ingredientsController.text = widget.recipe.ingredients ?? '';
    descriptionController.text = widget.recipe.description ?? '';
    selectedCategory = widget.recipe.category;
    selectedImages =
        widget.recipe.imageUrls.map((imageUrl) => XFile(imageUrl)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: CustomAppBar(
        title: 'Edit Recipe',
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
                      decoration: const InputDecoration(
                        labelText: 'Item Name',
                        labelStyle: TextStyle(
                            color: black,
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                      ),
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
                      keyboardType: TextInputType.number, // Set the keyboardType to number
                      decoration: const InputDecoration(
                        labelText: 'Duration (mins)',
                        labelStyle: TextStyle(
                            color: black,
                            fontWeight: FontWeight.w400,
                            fontSize: 16
                            ),
                      ),
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
                        labelStyle: const TextStyle(
                          color: Colors.black, 
                          fontSize: 16, 
                        ),
                        // Remove the box and use an underline
                        border: const UnderlineInputBorder(),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),

                    const SizedBox(height: 25.0),
                    TextFormField(
                      controller: ingredientsController,
                      decoration: const InputDecoration(
                        labelText: 'Ingredients',
                        labelStyle: TextStyle(
                            color: black,
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                      ),
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
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        labelStyle: TextStyle(
                            color: black,
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                      ),
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

                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () {
                        _selectPhotosFromGallery();
                      },
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('Upload Photos'),
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                            categoryColor), 
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

                            widget.onRecipeUpdated(newRecipe);

                            itemController.clear();
                            durationController.clear();
                            ingredientsController.clear();
                            descriptionController.clear();
                            selectedCategory = '';

                            setState(() {
                              selectedImages.clear();
                            });
                            // Show the success Snackbar
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Center(
                                  child: Text('Edited successfully'),
                                ),
                              ),
                            );
                            Navigator.pop(context);
                          }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(secondaryColor),
                      ),
                      child: const Text('Edit Recipe'),
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