import 'package:flutter/material.dart';
import 'package:inventory/listItems.dart';
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
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter food Name",
            )
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: TextField(
            controller: categoryController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter food Category",
            )
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: TextField(
            controller: quantityController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter food Quantity",
            )
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: TextField(
            controller: sizeController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter food Size",
            )
          ),
        ),
          ElevatedButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(const EdgeInsets.all(8)),
            ),
            onPressed: () {
              itemObject.addAll({
                "name": nameController.text,
                "category": categoryController.text,
                "quantity": quantityController.text,
                "size": sizeController.text
                });
              db.add(itemObject);
              },
            child: Text("Enter"),
          ),
        ]
      ),
    );
  }
}