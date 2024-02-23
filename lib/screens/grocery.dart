import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:form/data/categories.dart';
import 'package:form/data/dummy.dart';
import 'package:form/models/category_model.dart';
import 'package:form/screens/new_item_screen.dart';
import 'package:form/models/grocery_item.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class GroceryScreen extends StatefulWidget {
  static final id = "GroceryScreen";
  GroceryScreen({super.key});

  @override
  State<GroceryScreen> createState() => _GroceryScreenState();
}

class _GroceryScreenState extends State<GroceryScreen> {
  List<GroceryItem> groceryItems2 = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbResponse();
    isLoading = true;
  }

  _addItems() async {
    try {
      final updated = await Navigator.of(context).push<GroceryItem>(
        MaterialPageRoute(
          builder: (context) => const NewScreen(),
        ),
      );

      if (updated == null) {
        return;
      }

      groceryItems2.add(GroceryItem(
          category: updated.category,
          id: updated.id,
          name: updated.name,
          quantity: updated.quantity));
      setState(() {});
    } catch (e) {
      print('Failed to load data: $e');
    }
  }

  Future<List<Map<String, dynamic>>?> dbResponse() async {
    var response;

    try {
      var url =
          Uri.https('forms-267dd-default-rtdb.firebaseio.com', 'list.json');
      response = await http.get(url);
    } catch (e) {
      print(e);
    }
    List<GroceryItem> list = [];
    final Map<String, dynamic> deCodedList = jsonDecode(response.body);
    for (final item in deCodedList.entries) {
      var _category = categories.entries
          .firstWhere(
              (element) => element.value.categoryTitle == item.value['type'])
          .value;

      list.add(GroceryItem(
          category: _category,
          id: item.key,
          name: item.value['title'],
          quantity: item.value['quantity']));
    }

    setState(() {
      groceryItems2 = list;
    });

    isLoading = false;
  }

  remove(item) async {
    var deleteFailIndex = groceryItems2.indexOf(groceryItems2[item]);

    groceryItems2.remove(item);

    var url = Uri.https(
        'forms-267dd-default-rtdb.firebaseio.com', 'list/${item.id}.json');
    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      groceryItems2.insert(deleteFailIndex, item);
    }
  }

  bool isLoading = false;

  final spinkit = const SpinKitThreeBounce(
    color: Colors.white,
    size: 50.0,
  );

  @override
  Widget build(BuildContext context) {
    Widget bodyContent = Center(
      child: Text('No Data'),
    );

    if (groceryItems2.isNotEmpty) {
      bodyContent = ListView.builder(
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
              remove(groceryItems2[index]);
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
        }),
      );
    }

    return isLoading
        ? Center(child: spinkit)
        : Scaffold(
            appBar: AppBar(
              title: Text('My List'),
              actions: [
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addItems,
                )
              ],
            ),
            backgroundColor: Colors.black54,
            body: FutureBuilder(
              future: dbResponse(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return spinkit;
                }

                if (snapshot.data!.isEmpty) {
                  return bodyContent;
                }

                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }

                return ListView.builder(
                  itemCount: snapshot.data!.length,
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
                        remove(groceryItems2[index]);
                      },
                      key: ValueKey(DateTime.now().toString()),
                      child: ListTile(
                        title: Text(groceryItems2[index].name.toString()),
                        leading: Icon(
                          Icons.check_box,
                          color: groceryItems2[index].category.categoryColor,
                        ),
                        trailing:
                            Text(groceryItems2[index].quantity.toString()),
                      ),
                    );
                  }),
                );
              },
            ),
          );
  }
}





// ?var iterateMap = categories.entries.elementAt(index).value;
// itemCount: categories.entries.length,
