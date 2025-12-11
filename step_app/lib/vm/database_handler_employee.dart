import 'package:step_app/model/employee.dart';

import 'package:sqflite/sqflite.dart';

class EmployeeHandler {
  final Database db;
  EmployeeHandler(this.db);

  // CREATE
  Future<int> insertEmployee(Employee e) async =>
      await db.insert('Employee', {
        'employee_id': e.employee_id,
        'employee_senior_id': e.employee_senior_id,
        'employee_name': e.employee_name,
        'employee_phone': e.employee_phone,
        'employee_password': e.employee_password,
        'employee_role': e.employee_role,
        'employee_workplace': e.employee_workplace,
      });

  // READ ONE
  Future<Employee?> getEmployee(int id) async {
    final maps = await db.query(
      'Employee',
      where: 'employee_id=?',
      whereArgs: [id],
    );
    return maps.isNotEmpty ? Employee.fromMap(maps.first) : null;
  }

  // READ ALL
  Future<List<Employee>> getAllEmployees() async {
    final maps = await db.query('Employee');
    return maps.map((m) => Employee.fromMap(m)).toList();
  }

  // UPDATE
  Future<int> updateEmployee(Employee e) async => await db.update(
    'Employee',
    {
      'employee_senior_id': e.employee_senior_id,
      'employee_name': e.employee_name,
      'employee_phone': e.employee_phone,
      'employee_password': e.employee_password,
      'employee_role': e.employee_role,
      'employee_workplace': e.employee_workplace,
    },
    where: 'employee_id=?',
    whereArgs: [e.employee_id],
  );

  // DELETE
  Future<int> deleteEmployee(int id) async => await db.delete(
    'Employee',
    where: 'employee_id=?',
    whereArgs: [id],
  );
}
