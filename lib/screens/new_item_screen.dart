import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:form/data/categories.dart';
import 'package:form/models/category_model.dart';

class NewScreen extends StatefulWidget {
  static final id = 'NewScreen';

  const NewScreen({super.key});

  @override
  State<NewScreen> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formState = GlobalKey<FormState>();
    var _enterTitle;
    var _enterQuantity;
    var selectCategory = categories[Categories.vegetables];
    var selectCategory2;

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
                      child: DropdownButtonFormField(
                        value: selectCategory,
                        onChanged: (value) {
                          setState(() {
                            selectCategory = value;
                          });
                        },
                        items: [
                          for (final list in categories.entries)
                            DropdownMenuItem(
                              value: list.value,
                              child: Row(
                                children: [
                                  Container(
                                    height: 16,
                                    width: 16,
                                    color: list.value.categoryColor,
                                  ),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  Text(
                                    list.value.categoryTitle,
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
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
                          onPressed: () {
                            if (_formState.currentState!.validate()) {
                              _formState.currentState!.save();
                            }
                            print(_enterTitle);
                            print(_enterQuantity);
                          },
                          child: const Text('Save'))
                    ],
                  ),
                ),
                // DropdownButtonFormField(
                //     items: [
                //       for (final checkList in categories.entries)
                //         DropdownMenuItem(
                //             value: checkList.value,
                //             child: Text(checkList.value.categoryTitle))
                //     ],
                //     onChanged: (v) {
                //       print(v);
                //     })
              ],
            ),
          ),
        ));
  }
}


           // CupertinoPicker(
                    //   itemExtent: 32,
                    //   onSelectedItemChanged: (picked) {},
                    //   children: [
                    //     for (final list in categories.entries)
                    //       Row(
                    //         children: [
                    //           Container(
                    //             height: 16,
                    //             width: 16,
                    //             color: list.value.categoryColor,
                    //           ),
                    //           const SizedBox(
                    //             width: 7,
                    //           ),
                    //           Text(list.value.categoryTitle),
                    //         ],
                    //       ),
                    //   ],
                    // )