import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  AppDatabase._();
  static final AppDatabase instance = AppDatabase._();

  static const _dbName = 'step.db';
  static const _version = 1;

  Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    final dir = await getDatabasesPath();
    final path = join(dir, _dbName);

    _db = await openDatabase(
      path,
      version: _version,
      onCreate: (db, version) async {
        // ✅ 여기서 테이블 "전부" 생성
        await db.execute('''
          CREATE TABLE customer (
            customer_id INTEGER PRIMARY KEY AUTOINCREMENT,
            customer_name TEXT NOT NULL,
            customer_phone TEXT NOT NULL,
            customer_pw TEXT NOT NULL,
            customer_email TEXT NOT NULL,
            customer_address TEXT NOT NULL,
            customer_image TEXT,
            customer_lat REAL,
            customer_lng REAL
          )
        ''');

        await db.execute('''
          CREATE TABLE employee (
            employee_id INTEGER PRIMARY KEY AUTOINCREMENT,
            employee_senior_id INTEGER,
            employee_name TEXT NOT NULL,
            employee_phone TEXT NOT NULL,
            employee_password TEXT NOT NULL,
            employee_role TEXT NOT NULL,
            employee_workplace TEXT NOT NULL
          )
        ''');

        await db.execute('''
          CREATE TABLE manufacturer (
            manufacturer_id INTEGER PRIMARY KEY AUTOINCREMENT,
            manufacturer_name TEXT,
            manufacturer_phone TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE category_sex (
            category_sex_id INTEGER PRIMARY KEY,
            category_sex_name TEXT NOT NULL
          )
        ''');

        await db.insert('category_sex', {
          'category_sex_id': 1,
          'category_sex_name': 'WOMEN',
        });
        await db.insert('category_sex', {
          'category_sex_id': 2,
          'category_sex_name': 'MEN',
        });
        await db.execute('''
          CREATE TABLE branch (
            branch_id INTEGER PRIMARY KEY AUTOINCREMENT,
            branch_name TEXT,
            branch_phone TEXT,
            branch_location TEXT,
            branch_lat REAL,
            branch_lng REAL
          )
        ''');

        await db.execute('''
          CREATE TABLE categorycolor (
            category_color_id INTEGER PRIMARY KEY AUTOINCREMENT,
            category_color_name TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE categorymanufacturer (
            category_manufacturer_id INTEGER PRIMARY KEY AUTOINCREMENT,
            category_manufacturer_name TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE categorysize (
            category_size_id INTEGER PRIMARY KEY AUTOINCREMENT,
            category_size_name TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE product (
            product_id INTEGER PRIMARY KEY AUTOINCREMENT,
            category_manufacturer_id INTEGER NOT NULL,
            category_size_id INTEGER NOT NULL,
            category_color_id INTEGER NOT NULL,
            product_price REAL NOT NULL,
            product_quantity INTEGER NOT NULL,
            product_image BLOB NOT NULL
          )
        ''');
      },
    );

    return _db!;
  }
}
