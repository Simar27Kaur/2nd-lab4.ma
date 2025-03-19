import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  // Get the database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize the database
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'students.db');
    print('Database Path: $path');  // Debugging line
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // Create the table if not already created
  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE students(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        marks INTEGER
      )
    ''');
    print("Database table created."); // Debugging line
  }

  // Insert student into the database
  Future<int> insertStudent(Map<String, dynamic> student) async {
    Database db = await database;
    int result = await db.insert('students', student);
    print("Insert Result: $result");  // Debugging line
    return result;
  }

  // Retrieve the list of students from the database
  Future<List<Map<String, dynamic>>> getStudents() async {
    Database db = await database;
    List<Map<String, dynamic>> students = await db.query('students');
    print("Fetched Students: $students");  // Debugging line
    return students;
  }
}
