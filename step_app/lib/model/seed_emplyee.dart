import 'package:step_app/model/employee.dart';

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
