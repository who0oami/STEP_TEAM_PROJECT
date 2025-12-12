class Branch {
  int? branch_id;
  String branch_name;
  String branch_phone;
  String branch_location;
  double branch_lat;
  double branch_lng;

  Branch({
    this.branch_id,
    required this.branch_name,
    required this.branch_phone,
    required this.branch_location,
    required this.branch_lat,
    required this.branch_lng,
  });

  Branch.fromMap(Map<String, dynamic> res)
    : branch_id = res['branch_id'],
      branch_name = res['branch_name'],
      branch_phone = res['branch_phone'],
      branch_location = res['branch_location'],
      branch_lat = res['branch_lat'],
      branch_lng = res['branch_lng'];
}
