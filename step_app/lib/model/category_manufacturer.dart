class Category_manufacturer {
  int? category_manufacturer_id;
  String category_manufacturer_name;

  Category_manufacturer({
    this.category_manufacturer_id,
    required this.category_manufacturer_name,
  });

  Category_manufacturer.fromMap(Map<String, dynamic> res)
    : category_manufacturer_id =
          res['category_manufacturer_id'],
      category_manufacturer_name =
          res['category_manufacturer_name'];
}
