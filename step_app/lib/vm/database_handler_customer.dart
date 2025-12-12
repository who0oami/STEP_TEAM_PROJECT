import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:step_app/model/customer.dart';

class CustomerHandler {
  // DB 연결 및 초기화
  static Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), "step_app.db");

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE Customer (
            customer_id INTEGER PRIMARY KEY AUTOINCREMENT,
            customer_name TEXT,
            customer_phone TEXT,
            customer_pw TEXT,
            customer_email TEXT,
            customer_address TEXT,
            customer_image TEXT,
            customer_lat REAL,
            customer_lng REAL

          )
        ''');
      },
    );
  }

  Future<int> insertCustomer(Customer c) async {
    final db = await CustomerHandler.initDB();
    return await db.insert('Customer', c.toMap());
  }

  Future<Customer?> getCustomer(int id) async {
    final db = await CustomerHandler.initDB();

    final maps = await db.query(
      'Customer',
      where: 'customer_id = ?',
      whereArgs: [id],
    );

    return maps.isNotEmpty ? Customer.fromMap(maps.first) : null;
  }

  Future<List<Customer>> getAllCustomers() async {
    final db = await CustomerHandler.initDB();
    final maps = await db.query('Customer');
    return maps.map((e) => Customer.fromMap(e)).toList();
  }

  Future<int> updateCustomer(Customer c) async {
    final db = await CustomerHandler.initDB();
    return await db.update(
      'Customer',
      c.toMap(),
      where: 'customer_id = ?',
      whereArgs: [c.customer_id],
    );
  }

  Future<int> deleteCustomer(int id) async {
    final db = await CustomerHandler.initDB();
    return await db.delete(
      'Customer',
      where: 'customer_id = ?',
      whereArgs: [id],
    );
  }
}
