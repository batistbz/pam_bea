import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper{
  static Future<Database> initDB() async{
    final path = await getDatabasesPath();
    return openDatabase(
      join(path, 'localizacao.db'),
      onCreate: (db, version) async {
        await db.execute(
          '''
          CREATE TABLE localizacao(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            latitude TEXT,
            longitude TEXT,
            carimboData TEXT
          )
          '''
        );
      },
      version: 1,
    );
  }
  static Future<int> insertLocalizacao(double lat, double long) async {
    final db = await initDB();
    return await db.insert ('localizacao', {
      'latitude': lat,
      'longitude': long,
      'carimboData': DateTime.now().toString()
    });
  }
  static Future<List<Map<String, dynamic>>> getLocalizacao() async {
    final db = await initDB();
    return await db.query('localizacao');

    
  }
}