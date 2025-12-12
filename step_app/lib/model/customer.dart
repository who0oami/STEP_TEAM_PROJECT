class Customer {
  final int? customer_id;
  final String customer_name;
  final String customer_phone;
  final String customer_pw;
  final String customer_email;
  final String customer_address;
  final String? customer_image;

  Customer({
    this.customer_id,
    required this.customer_name,
    required this.customer_phone,
    required this.customer_pw,
    required this.customer_email,
    required this.customer_address,
    this.customer_image,
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
    };
  }
}
