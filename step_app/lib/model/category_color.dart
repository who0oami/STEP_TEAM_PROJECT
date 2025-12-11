class Category_color {
  int? category_color_id;
  String category_color_name;

  Category_color({
    this.category_color_id,
    required this.category_color_name,
  });

  Category_color.fromMap(Map<String, dynamic> res)
    : category_color_id = res['category_color_id'],
      category_color_name = res['category_color_name'];
}