import 'package:flutter/material.dart';
import 'package:tugas_sqlite/database/dbhelper.dart';
import 'package:tugas_sqlite/item/item.dart';

class EntryForm extends StatefulWidget {
  final Item? item;

  EntryForm({this.item});

  @override
  _EntryForm createState() => _EntryForm(this.item);
}

class _EntryForm extends State<EntryForm> {
  Item? item;

  _EntryForm(this.item);
  DbHelper db = DbHelper();

  TextEditingController? kode;
  TextEditingController? name;
  TextEditingController? price;
  TextEditingController? stok;

  @override
  void initState() {
    kode = TextEditingController(
        text: widget.item == null ? '' : widget.item!.kode);
    name = TextEditingController(
        text: widget.item == null ? '' : widget.item!.name);
    price = TextEditingController(
        text: widget.item == null ? '' : widget.item!.price.toString());
    stok = TextEditingController(
        text: widget.item == null ? '' : widget.item!.stok.toString());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      primary: Colors.blueGrey,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[500],
        title: item == null ? Text('Tambah') : Text('Ubah'),
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
            child: TextField(
              controller: kode,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelText: 'Kode',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: TextField(
              controller: name,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: TextField(
              controller: price,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: TextField(
              controller: stok,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Stok',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  child: (widget.item == null)
                      ? Text(
                          'Add',
                          textScaleFactor: 1.5,
                          style: TextStyle(color: Colors.white),
                        )
                      : Text(
                          'Update',
                          textScaleFactor: 1.5,
                          style: TextStyle(color: Colors.white),
                        ),
                  style: style,
                  onPressed: () {
                    upsert();
                  },
                ),
              ),
              Container(
                width: 5.0,
              ),
              Expanded(
                  child: ElevatedButton(
                      child: Text(
                        'Cancel',
                        textScaleFactor: 1.5,
                      ),
                      style: style,
                      onPressed: () {
                        Navigator.pop(context);
                      }))
            ],
          ),
        ],
      ),
    );
  }

  Future<void> upsert() async {
    if (widget.item != null) {
      //insert

      await db.update(Item.fromMap({
        'id': widget.item!.id,
        'kode': kode!.text,
        'name': name!.text,
        'price': int.parse(price!.text),
        'stok': int.parse(stok!.text),
      }));
      Navigator.pop(context, 'update');
    } else {
      //update
      await db.insert(Item(
        name: name!.text,
        kode: kode!.text,
        price: int.parse(price!.text),
        stok: int.parse(stok!.text),
      ));
      Navigator.pop(context, 'save');
    }
  }
}
