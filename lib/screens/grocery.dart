import 'package:flutter/material.dart';

import 'package:form/data/categories.dart';
import 'package:form/data/dummy.dart';
import 'package:form/models/category_model.dart';
import 'package:form/screens/new_item_screen.dart';
import 'package:form/models/grocery_item.dart';

class GroceryScreen extends StatefulWidget {
  static final id = "GroceryScreen";
  GroceryScreen({super.key});

  @override
  State<GroceryScreen> createState() => _GroceryScreenState();
}

class _GroceryScreenState extends State<GroceryScreen> {
  List<GroceryItem> groceryItems2 = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My List'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              var data = await Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => NewScreen()));

              if (data == null) {
                return;
              }
              groceryItems2.add(data);
              setState(() {});
              print('data $data');
            },
          )
        ],
      ),
      backgroundColor: Colors.black54,
      body: ListView.builder(
          itemCount: groceryItems2.length,
          itemBuilder: ((context, index) {
            return Dismissible(
              background: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.red,
                  child: Icon(Icons.delete),
                ),
              ),
              onDismissed: (value) {
                groceryItems2.removeAt(index);
              },
              key: ValueKey(DateTime.now().toString()),
              child: ListTile(
                title: Text(groceryItems2[index].name.toString()),
                leading: Icon(
                  Icons.check_box,
                  color: groceryItems2[index].category.categoryColor,
                ),
                trailing: Text(groceryItems2[index].quantity.toString()),
              ),
            );
          })),
    );
  }
}

// ?var iterateMap = categories.entries.elementAt(index).value;
// itemCount: categories.entries.length,
