import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                    )

                        //  DropdownButtonFormField(
                        //   value: selectCategory,
                        //   onChanged: (value) {
                        //     selectCategory = value;
                        //     setState(() {});
                        //   },
                        //   items: [
                        //     for (final list in categories.entries)
                        //       DropdownMenuItem(
                        //         value: list.value,
                        //         child: Row(
                        //           children: [
                        //             Container(
                        //               height: 16,
                        //               width: 16,
                        //               color: list.value.categoryColor,
                        //             ),
                        //             const SizedBox(
                        //               width: 7,
                        //             ),
                        //             Text(
                        //               list.value.categoryTitle,
                        //               style: const TextStyle(color: Colors.red),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //   ],
                        // ),
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

                            Navigator.pop(
                                context,
                                GroceryItem(
                                    category: selectCategory!,
                                    id: DateTime.now().toString(),
                                    name: _enterTitle,
                                    quantity: _enterQuantity));
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


    //  print(
    //                       'DropdownButton - New Value: ${(v as ).categoryTitle}');
    //                   print(
    //                       'DropdownButton - Updated Value: ${_selectCategory2}');
    //                   // });

    //                   print(' DropdownButtonFormField 2nd0 $_selectCategory2');
 

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


// DropdownButton(
//                     value: _selectCategory2,
//                     items: [
//                       for (final checkList in groceryItems)
//                         DropdownMenuItem(
//                             value: checkList, child: Text(checkList.name))
//                     ],
//                     onChanged: (v) {
//                       _selectCategory2 = v; // Update variable and rebuild UI
//                       // setState(() {});
//                     })