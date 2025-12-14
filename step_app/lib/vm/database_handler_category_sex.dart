import 'package:sqflite/sqflite.dart';
import 'package:step_app/model/category_sex.dart';
import 'package:step_app/vm/app_database.dart';

class DatabaseHandlerCategorySex {
  // =====================
  // Query (전체 조회)
  // =====================
  Future<List<Category_sex>> queryCategorySex() async {
    final Database db = await AppDatabase.instance.db;
    final result = await db.rawQuery(
      'select * from category_sex order by category_sex_id',
    );
    return result.map((e) => Category_sex.fromMap(e)).toList();
  }

  // =====================
  // Query (ID로 조회)
  // =====================
  Future<Category_sex?> getCategorySexById(int category_id) async {
    final Database db = await AppDatabase.instance.db;
    final result = await db.rawQuery(
      'select * from category_sex where category_sex_id = ?',
      [category_id],
    );

    if (result.isEmpty) return null;
    return Category_sex.fromMap(result.first);
  }
}
