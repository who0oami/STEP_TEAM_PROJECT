class branch {
  int? branch_id;
  String branch_name;
  String branch_phone;
  String branch_location;

  branch({
    this.branch_id,
    required this.branch_name,
    required this.branch_phone,
    required this.branch_location,
  });

  branch.fromMap(Map<String, dynamic> res)
    : branch_id = res['branch_id'],
      branch_name = res['branch_name'],
      branch_phone = res['branch_phone'],
      branch_location = res['branch_location'];
}
