import 'package:sqflite/sqflite.dart';
import 'package:tugas_sqlite/item/item.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper._internal();
  static Database? _database;

  final String tableName = 'tablePegawai';
  final String columnId = 'id';
  final String columnKode = 'kode';
  final String columnName = 'name';
  final String columnPrice = 'price';
  final String columnStok = 'stok';

  DbHelper._internal();
  factory DbHelper() => _instance;

  Future<Database?> get _db async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDb();
    return _database;
  }

  Future<Database?> _initDb() async {
    String databasePath = await getDatabasesPath();
    String path = databasePath + 'ittem.db';

    return await openDatabase(path, version: 4, onCreate: _createDb);
  }

  Future<void> _createDb(Database db, int version) async {
    var sql = "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY, "
        "$columnKode TEXT"
        "$columnName TEXT,"
        "$columnPrice INTEGER,"
        "$columnStok INTEGER)";
    await db.execute(sql);
  }

  Future<int?> insert(Item item) async {
    var dbClient = await _db;
    return await dbClient!.insert(tableName, item.toMap());
  }

  Future<List?> selectAll() async {
    var dbClient = await _db;
    var result = await dbClient!.query(tableName,
        columns: [columnId, columnKode, columnName, columnPrice, columnStok]);
    return result.toList();
  }

  Future<int?> update(Item item) async {
    var dbClient = await _db;
    return await dbClient!.update(tableName, item.toMap(),
        where: '$columnId = ?', whereArgs: [item.id]);
  }

  Future<int?> delete(int id) async {
    var dbClient = await _db;
    return await dbClient!
        .delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }
}
