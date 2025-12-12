class Customer {
  int? customer_id;
  String customer_name;
  String customer_phone;
  String customer_pw;
  String customer_email;
  String customer_address;
  String? customer_image; // nullable 유지
  double? customer_lat; // optional
  double? customer_lng; // optional

  Customer({
    this.customer_id,
    required this.customer_name,
    required this.customer_phone,
    required this.customer_pw,
    required this.customer_email,
    required this.customer_address,
    this.customer_image,
    this.customer_lat,
    this.customer_lng,
  });

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      customer_id: map['customer_id'],
      customer_name: map['customer_name'],
      customer_phone: map['customer_phone'],
      customer_pw: map['customer_pw'],
      customer_email: map['customer_email'],
      customer_address: map['customer_address'],
      customer_image: map['customer_image'],
      customer_lat: map['customer_lat']?.toDouble(),
      customer_lng: map['customer_lng']?.toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'customer_id': customer_id,
      'customer_name': customer_name,
      'customer_phone': customer_phone,
      'customer_pw': customer_pw,
      'customer_email': customer_email,
      'customer_address': customer_address,
      'customer_image': customer_image,
      'customer_lat': customer_lat,
      'customer_lng': customer_lng,
    };
  }
}
