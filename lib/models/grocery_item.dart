import 'package:form/data/categories.dart';
import 'package:form/models/category_model.dart';

class GroceryItem {
  GroceryItem(
      {required this.category,
      required this.id,
      required this.name,
      required this.quantity});

  final String id;
  final String name;
  final int quantity;
  final Category category;
}
