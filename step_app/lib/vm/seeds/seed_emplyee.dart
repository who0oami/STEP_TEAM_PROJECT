import 'package:step_app/model/employee.dart';
import 'package:step_app/vm/database_handler_employee.dart';

// seed_employee.dart
class SeedEmployee {
  static bool _inserted = false;

  static Future<void> insertSeed() async {
    if (_inserted) return;

    final handler = DatabaseHandlerEmployee();

    final List<Employee> seedEmployees = [
      // ======================
      // 본사 (이사)
      // ======================
      Employee(
        employee_id: 1,
        employee_senior_id: null,
        employee_name: '황이시아',
        employee_phone: '010-1423-1444',
        employee_password: '1234',
        employee_role: '이사',
        employee_workplace: '본사',
      ),

      // ======================
      // 강남점
      // ======================
      Employee(
        employee_id: 2,
        employee_senior_id: 1,
        employee_name: '김지훈',
        employee_phone: '010-5345-5544',
        employee_password: '1234',
        employee_role: '팀장',
        employee_workplace: '강남점',
      ),
      Employee(
        employee_id: 3,
        employee_senior_id: 2,
        employee_name: '이수민',
        employee_phone: '010-2235-0235',
        employee_password: '1234',
        employee_role: '매니저',
        employee_workplace: '강남점',
      ),
      Employee(
        employee_id: 4,
        employee_senior_id: 3,
        employee_name: '박준영',
        employee_phone: '010-2360-0343',
        employee_password: '1234',
        employee_role: '직원',
        employee_workplace: '강남점',
      ),

      // ======================
      // 홍대점
      // ======================
      Employee(
        employee_id: 5,
        employee_senior_id: 1,
        employee_name: '최유나',
        employee_phone: '010-2342-2301',
        employee_password: '1234',
        employee_role: '팀장',
        employee_workplace: '홍대점',
      ),
      Employee(
        employee_id: 6,
        employee_senior_id: 5,
        employee_name: '정민수',
        employee_phone: '010-2340-2342',
        employee_password: '1234',
        employee_role: '직원',
        employee_workplace: '홍대점',
      ),

      // ======================
      // 성수점
      // ======================
      Employee(
        employee_id: 7,
        employee_senior_id: 1,
        employee_name: '최유나',
        employee_phone: '010-2023-1551',
        employee_password: '1234',
        employee_role: '팀장',
        employee_workplace: '성수점',
      ),
      Employee(
        employee_id: 8,
        employee_senior_id: 5,
        employee_name: '정민수',
        employee_phone: '010-2634-0242',
        employee_password: '1234',
        employee_role: '직원',
        employee_workplace: '성수점',
      ),
    ];

    for (final e in seedEmployees) {
      await handler.insertEmployeeWithId(e);
    }

    _inserted = true;
  }
}

// import 'package:step_app/model/employee.dart';
// import 'package:sqflite/sqflite.dart';

// class SeedEmployee {
//   static Future<void> insertSeed(Database db) async {
//     // ⚠️ senior 관계 때문에 ID 순서 중요
//     for (final e in seedEmployees) {
//       await db.insert(
//         'employee',
//         {
//           'employee_id': e.employee_id,
//           'employee_senior_id': e.employee_senior_id,
//           'employee_name': e.employee_name,
//           'employee_phone': e.employee_phone,
//           'employee_password': e.employee_password,
//           'employee_role': e.employee_role,
//           'employee_workplace': e.employee_workplace,
//         },
//         conflictAlgorithm: ConflictAlgorithm.replace,
//       );
//     }
//   }
// }

// final List<Employee> seedEmployees = [
//   // ======================
//   // 본사 (이사)
//   // ======================
//   Employee(
//     employee_id: 1,
//     employee_senior_id: null,
//     employee_name: '황이시아',
//     employee_phone: '010-1423-1444',
//     employee_password: '1234',
//     employee_role: '이사',
//     employee_workplace: '본사',
//   ),

//   // ======================
//   // 강남점
//   // ======================
//   Employee(
//     employee_id: 2,
//     employee_senior_id: 1,
//     employee_name: '김지훈',
//     employee_phone: '010-5345-5544',
//     employee_password: '1234',
//     employee_role: '팀장',
//     employee_workplace: '강남점',
//   ),
//   Employee(
//     employee_id: 3,
//     employee_senior_id: 2,
//     employee_name: '이수민',
//     employee_phone: '010-2235-0235',
//     employee_password: '1234',
//     employee_role: '매니저',
//     employee_workplace: '강남점',
//   ),
//   Employee(
//     employee_id: 4,
//     employee_senior_id: 3,
//     employee_name: '박준영',
//     employee_phone: '010-2360-0343',
//     employee_password: '1234',
//     employee_role: '직원',
//     employee_workplace: '강남점',
//   ),

//   // ======================
//   // 홍대점
//   // ======================
//   Employee(
//     employee_id: 5,
//     employee_senior_id: 1,
//     employee_name: '최유나',
//     employee_phone: '010-2342-2301',
//     employee_password: '1234',
//     employee_role: '팀장',
//     employee_workplace: '홍대점',
//   ),
//   Employee(
//     employee_id: 6,
//     employee_senior_id: 5,
//     employee_name: '정민수',
//     employee_phone: '010-2340-2342',
//     employee_password: '1234',
//     employee_role: '직원',
//     employee_workplace: '홍대점',
//   ),
//   // ======================
//   // 성수점
//   // ======================
//   Employee(
//     employee_id: 7,
//     employee_senior_id: 1,
//     employee_name: '최유나',
//     employee_phone: '010-2023-1551',
//     employee_password: '1234',
//     employee_role: '팀장',
//     employee_workplace: '성수점',
//   ),
//   Employee(
//     employee_id: 8,
//     employee_senior_id: 5,
//     employee_name: '정민수',
//     employee_phone: '010-2634-0242',
//     employee_password: '1234',
//     employee_role: '직원',
//     employee_workplace: '성수점',
//   ),
// ];
