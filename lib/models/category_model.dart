import 'package:flutter/material.dart';

enum Categories {
  vegetables,
  fruit,
  other,
  hygiene,
  convenience,
  spices,
  sweets,
  carbs,
  dairy,
  meat
}

class Category {
  Category(this.categoryTitle, this.categoryColor);
  final String categoryTitle;
  final Color categoryColor;
}
