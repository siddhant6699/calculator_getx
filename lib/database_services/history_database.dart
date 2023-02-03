import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class HistoryHelper {
  static Database? _database;
  static const String tableName = 'calculations';
  static const String columnId = 'id';
  static const String columnExpression = 'expression';

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDatabase();
    return _database;
  }

  // function to initialize DB
  initDatabase() async {
    String path = join(await getDatabasesPath(), 'calculations.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) {
        db.execute(
          "CREATE TABLE $tableName ($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnExpression TEXT)",
        );
      },
    );
  }

  // function to save calculation
  Future<void> insertCalculation(String expression) async {
    final db = await database;
    await db!.insert(
      tableName,
      {columnExpression: expression},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // function to get all calculations
  Future<List<Map<String, dynamic>>> getCalculations() async {
    final db = await database;
    return db!.query(tableName, orderBy: '$columnId DESC', limit: 10);
  }

  // function to delete all calculations
  Future<void> deleteAllCalculations() async {
    final db = await database;
    await db!.delete(tableName);
  }
}
