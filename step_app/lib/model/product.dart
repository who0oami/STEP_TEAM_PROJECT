class Product {
  final int? product_id; // 제품 번호
  final String product_name; // 제품명
  final String product_color; // 제품 색상
  final String product_size; // 제품 사이즈
  final double product_price; // 제품 가격
  final int product_quantity; // 제품 수량

  Product({
    required this.product_id,
    required this.product_name,
    required this.product_color,
    required this.product_size,
    required this.product_price,
    required this.product_quantity,
  });

  Product.fromMap(Map<String, dynamic> res)
    : product_id = res['product_id'],
      product_name = res['product_name'],
      product_color = res['product_color'],
      product_size = res['product_size'],
      product_price = res['product_price'],
      product_quantity = res['product_quantity'];
}