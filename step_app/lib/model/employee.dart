class Employee {
  final int employee_id; // 직원 id
  final int? employee_senior_id; // 상급자 id 상급자 아이디가 없을수있어서 int?함
  final String employee_name; // 직원이름
  final String employee_phone; // 직원 전화번호
  final String employee_password; // 직원 비밀번호
  final String employee_role; // 직원 직책
  final String employee_workplace; // 직원 근무지

  Employee({
    required this.employee_id,
    this.employee_senior_id,
    required this.employee_name,
    required this.employee_phone,
    required this.employee_password,
    required this.employee_role,
    required this.employee_workplace,
  });

  Employee.fromMap(Map<String, dynamic> res)
    : employee_id = res['employee_id'],
      employee_senior_id = res['employee_senior_id'],
      employee_name = res['employee_name'],
      employee_phone = res['employee_phone'],
      employee_password = res['employee_password'],
      employee_role = res['employee_role'],
      employee_workplace = res['employee_workplace'];
}
