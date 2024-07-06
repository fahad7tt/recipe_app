import 'package:flutter/material.dart';
import 'package:recipe_app/const/color.dart';

Widget buildSearchBar(String searchQuery, Function setSearchQuery) {
  return Padding(
    padding: const EdgeInsets.only(top: 32.0, left: 20.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 320,
          height: 47,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: plusColor,
          ),
          child: TextFormField(
            decoration: const InputDecoration(
              hintText: 'Search',
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search, color: black),
            ),
            style: const TextStyle(color: black),
            onChanged: (value) {
              setSearchQuery(value);
            },
            onFieldSubmitted: (value) {},
          ),
        ),
      ],
    ),
  );
}
