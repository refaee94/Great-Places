import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<void> insert(String table, Map<String, Object> data) async {
    sql.Database sqlDB = await dataBase();
     sqlDB.insert(table, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<sql.Database> dataBase() async {
    final dbPath = await sql.getDatabasesPath();
    return  sql.openDatabase(path.join(dbPath, 'PlacesDB.db'),
        onCreate: (db, version) {
      return db.execute(
          'create Table places(id text primary key,title text,image text,lat real,lon real,address text)');
    }, version: 1);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    sql.Database sqlDB = await dataBase();
    return sqlDB.query(table);
  }
}
