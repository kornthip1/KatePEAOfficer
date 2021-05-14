import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLiteHelperType2 {
  final String nameDatabase = 'type2.db';
  final String nameTable = 'tableType2';
  final int version = 1;
  final String columnId = 'id';
  final String columnDoc = 'iddoc';
  final String columnName = 'namejob';
  final String columnImage = 'image';

  SQLiteHelperType2() {
    initailDatabase();
  }

  Future<Null> initailDatabase() async {
    await openDatabase(
      join(await getDatabasesPath(), nameDatabase),
      version: version,
      onCreate: (db, version) => db.execute(
          'CREATE TABLE $nameTable ($columnId INTEGER PRIMARY KEY, $columnDoc TEXT, $columnName TEXT, $columnImage TEXT)'),
    );
  }

 Future<Database> connectedDatabase() async {
    return await openDatabase(join(await getDatabasesPath(), nameDatabase) );
  }


  Future<Null> insertDatebase() async{}





}
