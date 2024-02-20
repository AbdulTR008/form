import 'package:flutter/material.dart';

import 'package:form/data/categories.dart';
import 'package:form/data/dummy.dart';
import 'package:form/models/category_model.dart';
import 'package:form/screens/new_item_screen.dart';

class GroceryScreen extends StatelessWidget {
  static final id = "GroceryScreen";
  const GroceryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My List'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, NewScreen.id);
            },
          )
        ],
      ),
      backgroundColor: Colors.black54,
      body: ListView.builder(
          itemCount: groceryItems.length,
          itemBuilder: ((context, index) {
            return ListTile(
              title: Text(groceryItems[index].name.toString()),
              leading: Icon(
                Icons.check_box,
                color: groceryItems[index].category.categoryColor,
              ),
              trailing: Text(groceryItems[index].quantity.toString()),
            );
          })),
    );
  }
}


// ?var iterateMap = categories.entries.elementAt(index).value;
    // itemCount: categories.entries.length,
