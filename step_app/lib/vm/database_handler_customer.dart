import 'package:sqflite/sqflite.dart';
import 'package:step_app/model/customer.dart';

class CustomerHandler {
  final Database db;
  CustomerHandler(this.db);

  Future<int> insertCustomer(Customer c) async =>
      await db.insert('Customer', {
        'customer_name': c.customer_name,
        'customer_phone': c.customer_phone,
        'customer_pw': c.customer_pw,
        'customer_email': c.customer_email,
        'customer_address': c.customer_address,
      });

  Future<Customer?> getCustomer(int id) async {
    final maps = await db.query(
      'Customer',
      where: 'customer_id=?',
      whereArgs: [id],
    );
    return maps.isNotEmpty ? Customer.fromMap(maps.first) : null;
  }

  Future<List<Customer>> getAllCustomers() async {
    final maps = await db.query('Customer');
    return maps.map((m) => Customer.fromMap(m)).toList();
  }

  Future<int> updateCustomer(Customer c) async => await db.update(
    'Customer',
    {
      'customer_name': c.customer_name,
      'customer_phone': c.customer_phone,
      'customer_pw': c.customer_pw,
      'customer_email': c.customer_email,
      'customer_address': c.customer_address,
    },
    where: 'customer_id=?',
    whereArgs: [c.customer_id],
  );

  Future<int> deleteCustomer(int id) async => await db.delete(
    'Customer',
    where: 'customer_id=?',
    whereArgs: [id],
  );
}
