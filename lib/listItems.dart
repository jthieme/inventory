import 'package:flutter/material.dart';

class ListItem extends StatefulWidget {
  const ListItem({super.key, required this.item});
  final Map item;

  // const ListItem(this.item);
  // const ListItem({super.key, required this.item});

  @override
  _ListItemState createState() => _ListItemState(item: item);
}

class _ListItemState extends State<ListItem>{
  // const _ListItemState({super.key, required this.item});
  // final ListItem item;

  _ListItemState({required this.item});
  final Map item;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Inventory"),
      ),
      body: 
      // ListView.builder(
      //   itemCount: items.length,
      //   itemBuilder: (context, index) {
      //     return ListTile(
      //       title: Text(items[index].title),
      //     );
      //   }
      // ) 
      //
      Column(children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Text(item["category"]),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 30),
          child: Text(item["name"]),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 30),
          child: Text(item["quantity"]),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 30),
          child: Text(item["size"]),
        ),
      ]
      ),
    );
  }
}