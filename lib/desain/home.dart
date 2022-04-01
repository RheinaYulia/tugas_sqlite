import 'package:flutter/material.dart';
import 'package:tugas_sqlite/database/dbhelper.dart';
import 'package:tugas_sqlite/desain/entryform.dart';
import 'package:tugas_sqlite/item/item.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  List<Item> itemlist = [];
  DbHelper db = DbHelper();

  @override
  void initState() {
    _selectAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[500],
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
              child: Text("Tambah Item"),
              onPressed: () async {
                _openFormCreate();
              },
            ),
          ),
        ),
      ]),

      // floatingActionButton: Container(
      //   height: 100,
      //   color: Colors.pink,
      //   child: FittedBox(
      //     child: FlatButton(
      //         shape: RoundedRectangleBorder(), onPressed: () {}),
      //   ),
      // ),

      // floatingActionButton: FloatingActionButton.extended(

      //   icon: Icon(Icons.add),
      //   label: Text('Refresh'),
      //   backgroundColor: Colors.red,
      //   shape: RoundedRectangleBorder(),
      //   onPressed: () {
      //     _openFormCreate();
      //   },
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   shape: RoundedRectangleBorder(),
      //   backgroundColor: Colors.red,
      //   onPressed: () {
      //     //add
      //     _openFormCreate();
      //   },
      // ),
    );
  }

  ListView createListView() {
    return ListView.builder(
      itemCount: itemlist.length,
      itemBuilder: (context, index) {
        Item item = itemlist[index];
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            onTap: () {
              //edit
              _openFormEdit(item);
            },
            leading: CircleAvatar(
              backgroundColor: Colors.red,
              child: Icon(Icons.ad_units),
            ),
            contentPadding: EdgeInsets.all(16),
            title: Text(
              '${item.name}',
              style: TextStyle(fontSize: 22),
            ),
            subtitle: Text('${item.price}'),
            trailing: FittedBox(
              fit: BoxFit.fill,
              child: Row(
                children: [
                  // button edit
                  IconButton(
                      onPressed: () {
                        _openFormEdit(item);
                      },
                      icon: Icon(Icons.edit)),
                  // button hapus
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      AlertDialog hapus = AlertDialog(
                        title: Text('Information'),
                        content: Container(
                          height: 100,
                          child: Column(
                            children: [
                              Text(
                                  'Apakah anda yakin ingin menghapus data ${item.name}'),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            child: Text('Ya'),
                            onPressed: () {
                              //delete
                              _delete(item, index);
                              Navigator.pop(context);
                            },
                          ),
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
          ),
        );
      },
    );
  }

  Future<void> _selectAll() async {
    var list = await db.selectAll();
    setState(() {
      itemlist.clear();
      list!.forEach((item) {
        itemlist.add(Item.fromMap(item));
      });
    });
  }

  Future<void> _delete(Item item, int position) async {
    await db.delete(item.id!);

    setState(() {
      itemlist.removeAt(position);
    });
  }

  Future<void> _openFormCreate() async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => EntryForm()));
    if (result == 'save') {
      await _selectAll();
    }
  }

  Future<void> _openFormEdit(Item item) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => EntryForm(item: item)));
    if (result == 'update') {
      await _selectAll();
    }
  }
}
