class Branch {
  int? branch_id; // 대리점 아이디
  String branch_name; // 대리점 이름
  String branch_phone; // 대리점 연락처
  String branch_location; // 대리점 위치
  double branch_lat; // 대리점 위도
  double branch_lng; // 대리점 경도

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
