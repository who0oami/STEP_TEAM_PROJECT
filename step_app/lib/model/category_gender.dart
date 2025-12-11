// ignore_for_file: non_constant_identifier_names

class CategoryGender {
  int category_gender_id;             // 성별ID_Primary Key
  String category_gender_name;          // 성별


  CategoryGender(
    {
      required this.category_gender_id,
      required this.category_gender_name,
    }
  );

  CategoryGender.fromMap(Map<String, dynamic> res)
  : category_gender_id = res['category_gender_id'],
    category_gender_name = res['category_gender_name'];
}