import 'package:sqflite/sqflite.dart';
import 'package:step_app/model/customer.dart';
import 'package:step_app/vm/app_database.dart';

class DatabaseHandlerCustomer {
  // =====================
  // INSERT
  // =====================
  Future<int> insertCustomer(Customer customer) async {
    final Database db = await AppDatabase.instance.db;
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

  /*
// =====================
// QUERY (이메일 중복 확인)
// =====================
Future<bool> checkEmailExists(String email) async {
  final db = await initializedDB();
  
  final result = await db.rawQuery(
    'SELECT customer_id FROM customer WHERE customer_email = ?',
    [email],
  );

  return result.isNotEmpty;
}

// =====================
  // QUERY (로그인 확인)
  // =====================
  Future<Customer?> hasCustomer(
    String email,
    String pw,
  ) async {
    final db = await initializedDB();
    final result = await db.rawQuery(
      'select * from customer where customer_email = ? and customer_pw = ?',
      [email, pw],
    );

    if (result.isEmpty) return null;
    return Customer.fromMap(result.first);
  }
*/

  // =====================
  // QUERY (전체 조회)
  // =====================
  Future<List<Customer>> queryCustomer() async {
    final Database db = await AppDatabase.instance.db;
    final List<Map<String, Object?>> result = await db
        .rawQuery('select * from customer');

    return result.map((e) => Customer.fromMap(e)).toList();
  }

  // =====================
  // QUERY (ID로 조회)
  // =====================
  Future<Customer?> getCustomerById(int customer_id) async {
    final Database db = await AppDatabase.instance.db;
    final result = await db.rawQuery(
      'select * from customer where customer_id = ?',
      [customer_id],
    );

    if (result.isEmpty) return null;
    return Customer.fromMap(result.first);
  }

  Future<Customer?> hasCustomer(
    String email,
    String pw,
  ) async {
    final Database db = await AppDatabase.instance.db;
    final result = await db.rawQuery(
      'select * from customer where customer_email = ? and customer_pw = ?',
      [email, pw],
    );

    if (result.isEmpty) return null;
    return Customer.fromMap(result.first);
  }

  // =====================================
  // QUERY (전화번호로 이메일 조회) - ForgotEmailPage 사용
  // =====================================

  Future<String?> findEmailByPhone(String phone) async {
    final Database db = await AppDatabase.instance.db;
    final List<Map<String, Object?>> result = await db
        .rawQuery(
          '''
    SELECT customer_email 
    FROM customer
    WHERE customer_phone = ?
    ''',
          [phone],
        );

    if (result.isEmpty) {
      return null;
    } else {
      final Map<String, Object?> row = result.first;
      return row['customer_email'] as String?;
    }
  }

  // =====================
  // QUERY (이메일 중복 확인)
  // =====================

  Future<bool> checkEmailExists(String email) async {
    final Database db = await AppDatabase.instance.db;
    final result = await db.rawQuery(
      'SELECT customer_id FROM customer WHERE customer_email = ?',
      [email],
    );
    return result.isNotEmpty;
  }

  // =====================
  // COUNT (고객 수 확인)
  // =====================

  Future<int> countCustomers() async {
    final Database db = await AppDatabase.instance.db;
    final result = await db.rawQuery(
      'SELECT COUNT(*) FROM customer',
    );
    final count = Sqflite.firstIntValue(result);

    return count ?? 0;
  }

  // =====================
  // UPDATE
  // =====================
  Future<int> updateCustomer(Customer customer) async {
    final Database db = await AppDatabase.instance.db;
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
    final Database db = await AppDatabase.instance.db;
    return await db.rawDelete(
      'delete from customer where customer_id = ?',
      [customer_id],
    );
  }
}
