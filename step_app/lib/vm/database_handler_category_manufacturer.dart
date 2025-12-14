import 'package:sqflite/sqflite.dart';
import 'package:step_app/model/category_manufacturer.dart';
import 'package:step_app/vm/app_database.dart';

class CategoryManufacturerHandler {
  Future<int> insertCategoryManufacturer(
    Category_manufacturer category_manufacturer,
  ) async {
    final Database db = await AppDatabase.instance.db;
    return await db.rawInsert(
      """
      insert into categorymanufacturer
      (category_manufacturer_name)
      values
      (?)
      """,
      [category_manufacturer.category_manufacturer_name],
    );
  }

  Future<List<Category_manufacturer>>
  queryCategoryManufacturer() async {
    final Database db = await AppDatabase.instance.db;
    final List<Map<String, Object?>> queryResult = await db.rawQuery(
      'select * from categorymanufacturer',
    );
    return queryResult
        .map((e) => Category_manufacturer.fromMap(e))
        .toList();
  }

  Future<int> updateCategoryManufacturer(
    Category_manufacturer category_manufacturer,
  ) async {
    final Database db = await AppDatabase.instance.db;
    return await db.rawUpdate(
      """
      update categorymanufacturer
      set category_manufacturer_name = ?
      where category_manufacturer_id = ?
      """,
      [
        category_manufacturer.category_manufacturer_name,
        category_manufacturer.category_manufacturer_id,
      ],
    );
  }

  Future deleteCategoryManufacturer(
    int category_manufacturer_id,
  ) async {
    final Database db = await AppDatabase.instance.db;
    await db.rawDelete(
      'delete from categorymanufacturer where category_manufacturer_id = ?',
      [category_manufacturer_id],
    );
  }
}
