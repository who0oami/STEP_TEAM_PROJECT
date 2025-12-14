import 'dart:typed_data';

class Product {
  final int? product_id; // 제품 번호_자동 증가 Primary Key
  final int category_manufacturer_id; // 제조사 카테고리 id
  final int category_size_id; // 사이즈 카테고리 id
  final int category_color_id; // 색상 카테고리 id
  final double product_price; // 제품 가격
  final int product_quantity; // 제품 수량
  final Uint8List product_image; // 제품 이미지
  Product({
    this.product_id,
    required this.category_manufacturer_id,
    required this.category_size_id,
    required this.category_color_id,
    required this.product_price,
    required this.product_quantity,
    required this.product_image,
  });

  Product.fromMap(Map<String, dynamic> res)
    : product_id = res['product_id'],
      category_manufacturer_id =
          res['category_manufacturer_id'],
      category_size_id = res['category_size_id'],
      category_color_id = res['category_color_id'],
      product_price = res['product_price'],
      product_quantity = res['product_quantity'],
      product_image = res['product_image'];
}
