class Category_sex {
  int category_sex_id;
  String category_sex_name;

  Category_sex({
    required this.category_sex_id,
    required this.category_sex_name,
  });

  Category_sex.fromMap(Map<String, dynamic> res)
    : category_sex_id = res['category_sex_id'],
      category_sex_name = res['category_sex_name'];
}
