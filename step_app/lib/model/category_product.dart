class CategoryProduct {
  int category_product_id;
  String category_product_name;

  CategoryProduct({
    required this.category_product_id,
    required this.category_product_name,
  });

  factory CategoryProduct.fromMap(Map<String, dynamic> res) {
    return CategoryProduct(
      category_product_id: res['category_product_id'],
      category_product_name: res['category_product_name'],
    );
  }
}
