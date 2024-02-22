import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:form/data/categories.dart';
import 'package:form/data/dummy.dart';
import 'package:form/models/category_model.dart';
import 'package:form/models/grocery_item.dart';
import 'package:form/screens/grocery.dart';

class NewScreen extends StatefulWidget {
  static final id = 'NewScreen';

  const NewScreen({super.key});

  @override
  State<NewScreen> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  var _enterTitle;
  var _enterQuantity;
  var selectCategory = categories[Categories.vegetables];

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formState = GlobalKey<FormState>();

    return Scaffold(
        appBar: AppBar(title: Text('Add New_Item')),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Form(
          key: _formState,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  onSaved: (value) {
                    _enterTitle = value;
                  },
                  validator: (value) {
                    if (value == null || value.trim() == '') {
                      return 'Error';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    label: Text('Title'),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFormField(
                        onSaved: (value) {
                          _enterQuantity = int.parse(value!);
                        },
                        initialValue: '1',
                        validator: (value) {
                          if (value == null ||
                              value.trim() == '' ||
                              value.isEmpty ||
                              int.tryParse(value) == null) {
                            return 'Error';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          label: Text("Quantity"),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Center(
                      child: CupertinoPicker(
                        itemExtent: 40,
                        onSelectedItemChanged: (picked) {
                          selectCategory =
                              categories.entries.toList()[picked].value;
                        },
                        children: [
                          for (final list in categories.entries)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 16,
                                  width: 16,
                                  color: list.value.categoryColor,
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                Text(list.value.categoryTitle),
                              ],
                            ),
                        ],
                      ),
                    )),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          _formState.currentState!.reset();
                        },
                        child: const Text('Reset'),
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            if (_formState.currentState!.validate()) {
                              _formState.currentState!.save();
                            }

                            var url = Uri.https(
                                'forms-267dd-default-rtdb.firebaseio.com',
                                // 'forms-58623-default-rtdb.firebaseio.com',
                                'list.json');
                            var response = await http.post(
                              url,
                              headers: {'content-type': 'application/json'},
                              body: json.encode({
                                'title': _enterTitle,
                                'quantity': _enterQuantity,
                                'type': selectCategory!.categoryTitle
                              }),
                            );

                            print(
                                'response.statusCode  ${response.statusCode}');

                            if (response.statusCode == 200) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Data Saved'),
                                backgroundColor: Colors.green,
                              ));
                            }
                            if (!context.mounted) {
                              return;
                            }
                            Navigator.pop(context);

                            // Navigator.pop(
                            //     context,
                            //     GroceryItem(
                            //         category: selectCategory!,
                            //         id: DateTime.now().toString(),
                            //         name: _enterTitle,
                            //         quantity: _enterQuantity));
                          },
                          child: const Text('Save'))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
