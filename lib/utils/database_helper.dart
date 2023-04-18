import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class DatabaseHelper {
  static const _dbName = 'employee.db';
  static const _databaseVersion = 1;

  static const tableName = 'employees';

  static const columnId = 'id';
  static const columnName = 'name';
  static const columnRole = 'role';
  static const columnFromDate = 'fromDate';
  static const columnToDate = 'toDate';
  static const columnIsDeleted = 'isDeleted';

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
 
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

   _initDatabase() async {
    String path = p.join(await getDatabasesPath(), _dbName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

// creates database taable 
 Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $tableName (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            $columnName TEXT NOT NULL,
            $columnRole TEXT NOT NULL,
            $columnFromDate TEXT NOT NULL,
            $columnToDate TEXT NOT NULL,
            $columnIsDeleted BOOLEAN NOT NULL CHECK ($columnIsDeleted in (0,1)) 
          )
          ''');
  }

  Future<int> insert(Map<String,dynamic> data) async {
  Database db = await instance.database;
  return await db.insert(tableName, data,conflictAlgorithm: ConflictAlgorithm.replace);
}
 
Future<List<Map<String, dynamic>>> getAllRows() async {
  Database db = await instance.database;
  return await db.query(tableName, orderBy: "$columnId DESC");
}

Future<List<Map<String, dynamic>>> getRowById(int id) async {
  Database db = await instance.database;
  return await db.query(tableName, where: "$columnId = ?",whereArgs: [id], limit: 1);
}

Future<int> update(int id,Map<String,dynamic> newData) async {
  Database db = await instance.database;
  return await db.update(tableName,newData, where: '$columnId = ?', whereArgs: [id]);
}

Future<int> delete(int id) async {
  Database db = await instance.database;
  return await db.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
}

 
Future<void> clearTable() async {
  Database db = await instance.database;
  await db.rawQuery("DELETE FROM $tableName");
}

}
