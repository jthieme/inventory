import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory/addItem.dart';
import 'database.dart';

class ListItem extends StatefulWidget {
  const ListItem({super.key});

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  // Initialize database class
  final db = Database();

  // Initialize scrolling capabilities
  final _scroller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final Future<QuerySnapshot<Map<String, dynamic>>> future = db.read();

    return Scaffold(
        appBar: AppBar(
          title: const Text("Inventory"),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AddItem())).whenComplete(() => null);
              },
            )
          ],
        ),
        body: FutureBuilder(
            future: future,
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              var itemField = snapshot.data?.docs;
              if (snapshot.hasError) {
                return const Text("Error!");
              } else if (snapshot.data!.docs.isEmpty) {
                return Column(children: const [
                  Text(
                    "Inventory is Empty",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ]);
              }

              return Container(
                padding: const EdgeInsets.all(12.0),
                child: ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: _scroller,
                    shrinkWrap: true,
                    separatorBuilder: ((context, index) => const Divider(
                          color: Colors.black,
                        )),
                    itemCount: snapshot.data!.docs.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) => Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Flex(
                          direction: Axis.vertical,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                          Text(
                            snapshot.data?.docs[index].data()["category"],
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextItem('Name', '${itemField?[index].data()["name"]}'),
                          TextItem('Quantity', '${itemField?[index].data()['quantity']}'),
                          TextItem('Size', '${itemField?[index].data()['size']}'),
                          // Flexible(
                          //   fit: FlexFit.loose,
                          //   child: ListView.builder(
                          //     shrinkWrap: true,
                          //     padding: const EdgeInsets.all(6.0),
                          //     itemCount: itemField!.length,
                          //     itemBuilder:
                          //       (BuildContext context, int index) {
                          //         return Column(children: [
                          //           TextItem('Name', '${itemField[index].data()["name"]}'),
                          //           TextItem('Quantity', '${itemField[index].data()['quantity']}'),
                          //           TextItem('Size', '${itemField[index].data()['size']}'),
                          //         ]);
                          //       })
                          //   )
                        ])
                      )
                  ),
              );
        })
      );
  }
}

class TextItem extends StatelessWidget {
  final name;
  final field;
  TextItem(this.name, this.field);

  @override
  Widget build(BuildContext context) {
    return Text(
      "$name: $field",
      style: const TextStyle(
        fontSize: 20,
      ),
    );
  }
}
