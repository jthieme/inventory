import 'package:flutter/material.dart';
import 'package:inventory/listItems.dart';
import 'package:firebase_core/firebase_core.dart';
import 'listItems.dart';
import 'database.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {

  final nameController = TextEditingController();
  final categoryController = TextEditingController();
  final quantityController = TextEditingController();
  final sizeController = TextEditingController();

  Map<String, dynamic> itemObject = {};

  final db = Database();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Items"),
        

      ),
      body:
        //  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Column(children: <Widget>[
         Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: "Name *",
              border: OutlineInputBorder(),
              hintText: "Enter food Name",
            )
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: TextField(
            controller: categoryController,
            decoration: const InputDecoration(
              labelText: "Category *",
              border: OutlineInputBorder(),
              hintText: "Enter food Category",
            )
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: TextField(
            controller: quantityController,
            decoration: const InputDecoration(
              labelText: "Quantity *",
              border: OutlineInputBorder(),
              hintText: "Enter food Quantity",
            )
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: TextField(
            controller: sizeController,
            decoration: const InputDecoration(
              labelText: "Size",
              border: OutlineInputBorder(),
              hintText: "Enter food Size",
            )
          ),
        ),
        
          ElevatedButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(const EdgeInsets.all(8)),
            ),
            onPressed: () async {
              
              // If the Name, Category, or Quantity fields
              // are empty, show a pop up box
              if (nameController.text == '' 
              || categoryController.text == ''
              || quantityController.text == '') {
                // Tell user that the Name, Category, and Quantity fields must be filled out
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    content: 
                    const Text('Please ensure that the Name, Category and Quantity fields are filled out before submitting.'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              } else { 
              
              itemObject.addAll({
                "name": nameController.text,
                "category": categoryController.text,
                "quantity": quantityController.text,
                "size": sizeController.text
                });

              // Add entry to the database
              db.add(itemObject);

              // Tell user that it submitted successfully
              await showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  content: const Text('Your item has been submitted successfully!'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );

              // Reset values back to empty
              nameController.text = '';
              categoryController.text = '';
              quantityController.text = '';
              sizeController.text = '';
              
              // Navigate to the ListItem page
              // await Navigator.push(context, MaterialPageRoute(builder: (context) => const ListItem()));
              
            }
            },
            child: Text("Enter"),
          ),
          
        ]
      ),
    );
  }
}