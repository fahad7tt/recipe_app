import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/const/color.dart';
import 'package:recipe_app/widget/common_widgets.dart';

// ignore: must_be_immutable
class RecipeForm extends StatefulWidget {
  final TextEditingController itemController;
  final TextEditingController durationController;
  final TextEditingController ingredientsController;
  final TextEditingController descriptionController;
  String selectedCategory;
  final GlobalKey<FormState> formKey;
  final List<XFile> selectedImages;
  final VoidCallback selectPhotosFromGallery;
  final bool formSubmitted;
  final List<String> categories;

  RecipeForm({super.key, 
    required this.itemController,
    required this.durationController,
    required this.ingredientsController,
    required this.descriptionController,
    required this.selectedCategory,
    required this.formKey,
    required this.selectedImages,
    required this.selectPhotosFromGallery,
    required this.formSubmitted,
    required this.categories,
  });

  @override
  // ignore: library_private_types_in_public_api
  _RecipeFormState createState() => _RecipeFormState();
}

class _RecipeFormState extends State<RecipeForm> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: widget.formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: widget.itemController,
                    decoration: const InputDecoration(
                      labelText: 'Item Name',
                      labelStyle: TextStyle(
                        color: black,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
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
                    controller: widget.durationController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Duration (mins)',
                      labelStyle: TextStyle(
                        color: black,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
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
                    value: widget.selectedCategory.isNotEmpty
                        ? widget.selectedCategory
                        : null,
                    items: widget.categories.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        widget.selectedCategory = value.toString();
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Category',
                      labelStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      border: const UnderlineInputBorder(),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25.0),
                  TextFormField(
                    controller: widget.ingredientsController,
                    decoration: const InputDecoration(
                      labelText: 'Ingredients',
                      labelStyle: TextStyle(
                        color: black,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
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
                    controller: widget.descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      labelStyle: TextStyle(
                        color: black,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
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
                  if (widget.selectedImages.isNotEmpty)
                    selectedImagePreviews(widget.selectedImages),
                  const SizedBox(height: 25.0),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: widget.selectPhotosFromGallery,
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Upload Photos'),
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all<Color>(categoryColor),
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (widget.formSubmitted && widget.selectedImages.length < 3)
                    Center(
                      child: Text(
                        'Please upload at least 3 images',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  const SizedBox(height: 30.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
