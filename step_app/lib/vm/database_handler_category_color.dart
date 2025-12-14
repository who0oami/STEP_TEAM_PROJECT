import 'package:sqflite/sqflite.dart';

import 'package:step_app/model/category_color.dart';
import 'package:step_app/vm/app_database.dart';

class CategoryColorHandler {
  Future<int> insertCategorycolor(
    Category_color category_color,
  ) async {
    final Database db = await AppDatabase.instance.db;
    return await db.rawInsert(
      """
      insert into categorycolor
      (category_color_name)
      values
      (?)
      """,
      [category_color.category_color_name],
    );
  }

  Future<List<Category_color>> queryCategorycolor() async {
    final Database db = await AppDatabase.instance.db;
    final List<Map<String, Object?>> queryResult = await db.rawQuery(
      'select * from categorycolor',
    );
    return queryResult.map((e) => Category_color.fromMap(e)).toList();
  }

  Future<int> updateCategorycolor(
    Category_color category_color,
  ) async {
    final Database db = await AppDatabase.instance.db;
    return await db.rawUpdate(
      """
      update categorycolor
      set category_color_name = ?
      where category_color_id = ?
      """,
      [
        category_color.category_color_name,
        category_color.category_color_id,
      ],
    );
  }

  Future deleteCategorycolor(int category_color_id) async {
    final Database db = await AppDatabase.instance.db;
    await db.rawDelete(
      'delete from categorycolor where category_color_id = ?',
      [category_color_id],
    );
  }
}
