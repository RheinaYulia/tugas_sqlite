import 'package:tugas_sqlite/database/dbhelper.dart';
import 'package:tugas_sqlite/desain/entryform.dart';
import 'package:tugas_sqlite/item/item.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'dart:async';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  DbHelper dbHelper = DbHelper();
  int count = 0;

  List<Item>? itemList;
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      primary: Colors.grey[350],
    );
    if (itemList == null) {
      itemList = <Item>[];
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Item'),
      ),
      body: Column(children: [
        Expanded(
          child: createListView(),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              child: Text(
                "Tambah Item",
                style: TextStyle(color: Colors.black87),
              ),
              onPressed: () async {
                var item = await navigateToEntryForm(context, null);
                if (item != null) {
                  //TODO 2 Panggil Fungsi untuk Insert ke DB
                  int result = await dbHelper.insert(item);
                  if (result > 0) {
                    updateListView();
                  }
                }
              },
              style: style,
            ),
          ),
        ),
      ]),
    );
  }

  Future<Item?> navigateToEntryForm(BuildContext context, Item? item) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return EntryForm(item);
    }));
    return result;
  }

  ListView createListView() {
    TextStyle? textStyle = Theme.of(context).textTheme.headline5;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        Item item = itemList![index];
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.red,
              child: Icon(Icons.ad_units),
            ),
            title: Text(
              this.itemList![index].name,
              style: textStyle,
            ),
            subtitle: Text(this.itemList![index].price.toString()),
            trailing: FittedBox(
              child: Row(
                children: [
                  IconButton(
                      onPressed: () async {
                        var item = await navigateToEntryForm(
                            context, this.itemList![index]);
                      },
                      icon: Icon(Icons.edit)),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      AlertDialog hapus = AlertDialog(
                        title: Text('Information'),
                        content: Container(
                          height: 100,
                          child: Column(
                            children: [
                              Text(
                                  'Apakah anda yakin ingin menghapus data ${this.itemList![index].name}'),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                              child: Text('Ya'),
                              onPressed: () async {
                                //delete
                                int result = await dbHelper
                                    .delete(this.itemList![index].id);
                                if (result > 0) {
                                  updateListView();
                                }
                                Navigator.pop(context);
                              }),
                          TextButton(
                            child: Text('Tidak'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                      showDialog(context: context, builder: (context) => hapus);
                    },
                  ),
                ],
              ),
            ),
            onTap: () async {
              var item =
                  await navigateToEntryForm(context, this.itemList![index]);
              //TODO 4 Panggil Fungsi untuk Edit data
            },
          ),
        );
      },
    );
  }

  //update List item
  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      //TODO 1 Select data dari DB

      Future<List<Item>> itemListFuture = dbHelper.getItemList();
      itemListFuture.then((itemList) {
        setState(() {
          this.itemList = itemList;
          this.count = itemList.length;
        });
      });
    });
  }
}
