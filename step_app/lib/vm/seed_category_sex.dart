
import 'package:step_app/model/category_sex.dart';
import 'package:step_app/vm/database_handler_category_sex.dart';

class SeedCategorySex {
  final List<Category_sex> categorySexSeedData = [
    Category_sex(category_sex_id: 1, category_sex_name: 'WOMEN'),
    Category_sex(category_sex_id: 2, category_sex_name: 'MEN'),
  ];

  // DB에 삽입
  Future<void> insertSeedData() async {
    final dbHandler = DatabaseHandlerCategorySex();
    final db = await dbHandler.initializedDB();

    for (var c in categorySexSeedData) {
      await db.insert('category_sex', {
        'category_sex_id': c.category_sex_id,
        'category_sex_name': c.category_sex_name,
      });
    }
  }
}
