class Category_product {
  int? category_product_id;
  String category_product_name;

  Category_product({
    this.category_product_id,
    required this.category_product_name,
  });

  Category_product.fromMap(Map<String, dynamic> res)
    : category_product_id = res['category_product_id'],
      category_product_name = res['category_product_name'];
}