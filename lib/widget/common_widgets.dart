import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/const/color.dart';

Widget buildLogo() {
  return Padding(
    padding: const EdgeInsets.only(top: 20.0),
    child: Image.asset(
      'assets/images/logo.png',
      width: 100.0,
      height: 100.0,
    ),
  );
}

Widget buildHeader(String title, String subtitle) {
  return Column(
    children: [
      const SizedBox(height: 15.0),
      Text(
        title,
        style: const TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
          color: boldTextColor,
        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 5.0),
      Text(
        subtitle,
        style: const TextStyle(
          fontSize: 17.0,
          color: grey,
        ),
      ),
      const SizedBox(height: 30.0),
    ],
  );
}

TextFormField buildTextFormField({
  TextEditingController? controller,
  String labelText = '',
  Icon? prefixIcon,
  Widget? suffixIcon,
  bool isObscureText = false,
  String? Function(String?)? validator,
  VoidCallback? onToggleVisibility, 
  bool showToggleVisibility = false, 
}) {
  return TextFormField(
    controller: controller,
    obscureText: isObscureText,
    decoration: InputDecoration(
      labelText: labelText,
      prefixIcon: prefixIcon,
      suffixIcon: showToggleVisibility
          ? IconButton(
              onPressed: onToggleVisibility,
              icon: Icon(
                isObscureText ? Icons.visibility : Icons.visibility_off,
              ),
            )
          : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      contentPadding: const EdgeInsets.all(10.0),
    ),
    validator: validator,
  );
}

ElevatedButton buildElevatedButton({
  VoidCallback? onPressed,
  String label = '',
  Color? buttonColor,
  Size? buttonSize,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: buttonColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.0),
      ),
    ).copyWith(
      fixedSize: WidgetStateProperty.all(buttonSize),
    ),
    child: Text(
      label,
      style: const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget selectedImagePreviews(List<XFile> selectedImages) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: selectedImages.map((xFile) {
        return Container(
          width: 150,
          height: 150,
          margin: const EdgeInsets.all(8),
          child: Image.file(
            File(xFile.path),
            fit: BoxFit.cover,
          ),
        );
      }).toList(),
    ),
  );
}

List<String> categories = [
  'Veg',
  'Non Veg',
  'Curry',
  'Juice',
  'Noodles',
  'Desserts',
  'Pizza',
  'Soup',
  'Others'
];

Future<List<XFile>> selectPhotosFromGallery() async {
  try {
    final pickedImages = await ImagePicker().pickMultiImage();
    return pickedImages;
  } catch (e) {
    return [];
  }
}

final TextEditingController itemController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController ingredientsController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String selectedCategory = '';
  
  List<XFile> selectedImages = [];
  bool formSubmitted = false;
  List<XFile> pickedImages = [];
  