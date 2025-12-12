import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:step_app/model/employee.dart';

class DatabaseHandlerEmployee {
  Future<Database> initializedDB() async {
    final String path = await getDatabasesPath();

    return openDatabase(
      join(path, 'step.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          create table employee (
            employee_id integer primary key autoincrement,
            employee_senior_id integer,
            employee_name text not null,
            employee_phone text not null,
            employee_password text not null,
            employee_role text not null,
            employee_workplace text not null
          )
        ''');
      },
    );
  }

  // =====================
  // INSERT
  // =====================
  Future<int> insertEmployee(Employee employee) async {
    final db = await initializedDB();
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

  // =====================
  // QUERY (전체 조회)
  // =====================
  Future<List<Employee>> queryEmployee() async {
    final db = await initializedDB();
    final List<Map<String, Object?>> result = await db.rawQuery(
      'select * from employee',
    );

    return result.map((e) => Employee.fromMap(e)).toList();
  }

  // =====================
  // UPDATE
  // =====================
  Future<int> updateEmployee(Employee employee) async {
    final db = await initializedDB();
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
    final db = await initializedDB();
    return await db.rawDelete('delete from employee where employee_id = ?', [
      Employee_id,
    ]);
  }
}
