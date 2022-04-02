class Item {
  int? _id;
  String? _kode;
  String? _name;
  int? _price;
  int? _stok;

  int get id => _id!;

  String get kode => this._kode!;
  set kode(String value) => this._kode = value;

  String get name => this._name!;
  set name(String value) => this._name = value;

  get price => this._price;
  set price(value) => this._price = value;

  get stok => this._stok;
  set stok(value) => this._stok = value;

// konstruktor versi 1
  Item(this._kode, this._name, this._price, this._stok);

// konstruktor versi 2: konversi dari Map ke Item
  Item.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._kode = map['kode'] as String;
    this._name = map['name'] as String;
    this._price = map['price'];
    this._stok = map['stok'];
  }
  // konversi dari Item ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['kode'] = kode;
    map['name'] = name;
    map['price'] = price;
    map['stok'] = stok;
    return map;
  }
}
