import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:step_app/model/customer.dart';

class DatabaseHandlerCustomer {
  Future<Database> initializedDB() async {
    final String path = await getDatabasesPath();

    return openDatabase(
      join(path, 'step.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          create table customer (
            customer_id integer primary key autoincrement,
            customer_name text not null,
            customer_phone text not null,
            customer_pw text not null,
            customer_email text not null,
            customer_address text not null,
            customer_image text,
            customer_lat real,
            customer_lng real
          )
        ''');
      },
    );
  }

  // =====================
  // INSERT
  // =====================
  Future<int> insertCustomer(Customer customer) async {
    final db = await initializedDB();
    return await db.rawInsert(
      '''
      insert into customer
      (
        customer_name,
        customer_phone,
        customer_pw,
        customer_email,
        customer_address,
        customer_image,
        customer_lat,
        customer_lng
      )
      values (?,?,?,?,?,?,?,?)
      ''',
      [
        customer.customer_name,
        customer.customer_phone,
        customer.customer_pw,
        customer.customer_email,
        customer.customer_address,
        customer.customer_image,
        customer.customer_lat,
        customer.customer_lng,
      ],
    );
  }

  // =====================
  // QUERY (전체 조회)
  // =====================
  Future<List<Customer>> queryCustomer() async {
    final db = await initializedDB();
    final List<Map<String, Object?>> result = await db.rawQuery(
      'select * from customer',
    );

    return result.map((e) => Customer.fromMap(e)).toList();
  }

  // =====================
  // QUERY (ID로 조회)
  // =====================
  Future<Customer?> getCustomerById(int customer_id) async {
    final db = await initializedDB();
    final result = await db.rawQuery(
      'select * from customer where customer_id = ?',
      [customer_id],
    );

    if (result.isEmpty) return null;
    return Customer.fromMap(result.first);
  }

  // =====================
  // UPDATE
  // =====================
  Future<int> updateCustomer(Customer customer) async {
    final db = await initializedDB();
    return await db.rawUpdate(
      '''
      update customer
      set
        customer_name = ?,
        customer_phone = ?,
        customer_pw = ?,
        customer_email = ?,
        customer_address = ?,
        customer_image = ?,
        customer_lat = ?,
        customer_lng = ?
      where customer_id = ?
      ''',
      [
        customer.customer_name,
        customer.customer_phone,
        customer.customer_pw,
        customer.customer_email,
        customer.customer_address,
        customer.customer_image,
        customer.customer_lat,
        customer.customer_lng,
        customer.customer_id,
      ],
    );
  }

  // =====================
  // DELETE
  // =====================
  Future<int> deleteCustomer(int customer_id) async {
    final db = await initializedDB();
    return await db.rawDelete('delete from customer where customer_id = ?', [
      customer_id,
    ]);
  }
}
