import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'your_database_name.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createTables,
    );
  }

  Future<void> _createTables(Database db, int version) async {
    // Create Instructor table
    await db.execute('''
      CREATE TABLE instructor (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT,
        phone TEXT
      )
    ''');

    // Create Student table
    await db.execute('''
      CREATE TABLE student (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT,
        password TEXT,
        phone TEXT
      )
    ''');

    // Create InstructorStudent junction table
    await db.execute('''
      CREATE TABLE instructor_student (
        instructor_id INTEGER,
        student_id INTEGER,
        PRIMARY KEY (instructor_id, student_id),
        FOREIGN KEY (instructor_id) REFERENCES instructor (id) ON DELETE CASCADE,
        FOREIGN KEY (student_id) REFERENCES student (id) ON DELETE CASCADE
      )
    ''');

    // Create DayProp table
    await db.execute('''
      CREATE TABLE day_prop (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        day_name TEXT,
        from_time TEXT,
        to_time TEXT,
        instructor_id INTEGER,
        FOREIGN KEY (instructor_id) REFERENCES instructor (id) ON DELETE CASCADE
      )
    ''');
  }
}
