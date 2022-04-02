import 'package:flutter/material.dart';

import 'package:tugas_sqlite/item/item.dart';

class EntryForm extends StatefulWidget {
  Item? item;

  EntryForm(this.item);

  @override
  EntryFormState createState() => EntryFormState(this.item);
}

//class controller
class EntryFormState extends State<EntryForm> {
  Item? item;
  EntryFormState(this.item);

  TextEditingController kodeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController stokController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      primary: Colors.blueGrey[500],
    );

    //kondisi
    if (item != null) {
      kodeController.text = item!.kode;
      nameController.text = item!.name;
      priceController.text = item!.price.toString();
      stokController.text = item!.stok.toString();
    }
    //rubah
    return Scaffold(
        appBar: AppBar(
          title: item == null ? Text('Tambah') : Text('Ubah'),
          leading: Icon(Icons.keyboard_arrow_left),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: ListView(
            children: <Widget>[
              // kode
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: kodeController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Kode Barang',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),
              // nama
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Nama Barang',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),

              // harga
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Harga',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),

              // stok
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: stokController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Stok',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),
              // tombol button
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Row(
                  children: <Widget>[
                    // tombol simpan
                    Expanded(
                      child: ElevatedButton(
                        child: Text(
                          'Save',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          if (item == null) {
                            // tambah data
                            item = Item(
                              kodeController.text,
                              nameController.text,
                              int.parse(priceController.text),
                              int.parse(
                                stokController.text,
                              ),
                            );
                          } else {
                            // ubah data
                            item?.kode = kodeController.text;
                            item?.name = nameController.text;
                            item?.price = int.parse(priceController.text);
                            item?.stok = int.parse(stokController.text);
                          }
                          // kembali ke layar sebelumnya dengan membawa objek item
                          Navigator.pop(context, item);
                        },
                        style: style,
                      ),
                    ),
                    Container(
                      width: 5.0,
                    ),
                    // tombol batal
                    Expanded(
                      child: ElevatedButton(
                        style: style,
                        child: Text(
                          'Cancel',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
