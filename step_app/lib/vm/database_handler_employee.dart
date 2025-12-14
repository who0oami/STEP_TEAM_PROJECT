import 'package:sqflite/sqflite.dart';
import 'package:step_app/model/employee.dart';
import 'package:step_app/vm/app_database.dart';

class DatabaseHandlerEmployee {
  // =====================
  // INSERT
  // =====================
  Future<int> insertEmployee(Employee employee) async {
    final Database db = await AppDatabase.instance.db;
    return await db.rawInsert(
      '''
      insert into employee
      (
        employee_senior_id,
        employee_name,
        employee_phone,
        employee_password,
        employee_role,
        employee_workplace
      )
      values (?,?,?,?,?,?)
      ''',
      [
        employee.employee_senior_id,
        employee.employee_name,
        employee.employee_phone,
        employee.employee_password,
        employee.employee_role,
        employee.employee_workplace,
      ],
    );
  }

  // 상사 id로 인해 필요함 Employee seed
  Future<int> insertEmployeeWithId(Employee e) async {
    final db = await AppDatabase.instance.db;
    return await db.rawInsert(
      '''
    insert into employee
    (
      employee_id,
      employee_senior_id,
      employee_name,
      employee_phone,
      employee_password,
      employee_role,
      employee_workplace
    )
    values (?, ?, ?, ?, ?, ?, ?)
    ''',
      [
        e.employee_id,
        e.employee_senior_id,
        e.employee_name,
        e.employee_phone,
        e.employee_password,
        e.employee_role,
        e.employee_workplace,
      ],
    );
  }

  // =====================
  // QUERY (전체 조회)
  // =====================
  Future<List<Employee>> queryEmployee() async {
    final Database db = await AppDatabase.instance.db;
    final List<Map<String, Object?>> result = await db
        .rawQuery('select * from employee');

    return result
        .map((e) => Employee.fromMap(e))
        .toList();
  }

  // =====================
  // UPDATE
  // =====================
  Future<int> updateEmployee(Employee employee) async {
    final Database db = await AppDatabase.instance.db;
    return await db.rawUpdate(
      '''
      update employee
      set
        employee_senior_id = ?,
        employee_name = ?,
        employee_phone = ?,
        employee_password = ?,
        employee_role = ?,
        employee_workplace = ?
      where employee_id = ?
      ''',
      [
        employee.employee_senior_id,
        employee.employee_name,
        employee.employee_phone,
        employee.employee_password,
        employee.employee_role,
        employee.employee_workplace,
        employee.employee_id,
      ],
    );
  }

  // =====================
  // DELETE
  // =====================
  Future<int> deleteEmployee(int Employee_id) async {
    final Database db = await AppDatabase.instance.db;
    return await db.rawDelete(
      'delete from employee where employee_id = ?',
      [Employee_id],
    );
  }
}
