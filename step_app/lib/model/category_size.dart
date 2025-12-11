class Category_size {
  int? category_size_id;
  String category_size_name;

  Category_size({
    this.category_size_id,
    required this.category_size_name,
  });

  Category_size.fromMap(Map<String, dynamic> res)
    : category_size_id = res['category_size_id'],
      category_size_name = res['category_size_name'];
}
