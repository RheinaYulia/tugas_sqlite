class Item {
  int? id;
  String? kode;
  String? name;
  int? price;
  int? stok;

  Item({
    this.id,
    this.kode,
    this.name,
    this.price,
    this.stok,
  });

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = id;
    }
    map['kode'] = kode;
    map['name'] = name;
    map['price'] = price;
    map['stok'] = stok;

    return map;
  }

  Item.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.kode = map['kode'] as String;
    this.name = map['name'] as String;
    this.price = map['price'];
    this.stok = map['stok'];
  }
}
