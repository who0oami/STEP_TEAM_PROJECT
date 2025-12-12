class Customer {
  int? customer_id;
  String customer_name;
  String customer_phone;
  String customer_pw;
  String customer_email;
  String customer_address;
  double customer_lat;
  double customer_lng;
  Customer({
    this.customer_id,
    required this.customer_name,
    required this.customer_phone,
    required this.customer_pw,
    required this.customer_email,
    required this.customer_address,
    required this.customer_lat,
    required this.customer_lng,
  });

  Customer.fromMap(Map<String, dynamic> res)
    : customer_id = res['customer_id'],
      customer_name = res['customer_name'],
      customer_phone = res['customer_phone'],
      customer_pw = res['customer_pw'],
      customer_email = res['customer_email'],
      customer_address = res['customer_address'],
      customer_lat = res['customer_lat'],
      customer_lng = res['customer_lng'];
}
