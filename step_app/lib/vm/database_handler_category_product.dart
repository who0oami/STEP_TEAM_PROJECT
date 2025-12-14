import 'package:sqflite/sqflite.dart';

import 'package:step_app/model/category_product.dart';
import 'package:step_app/vm/app_database.dart';

class CategoryProductHandler {
  Future<int> insertCategoryProduct(
    Category_product category_product,
  ) async {
    final Database db = await AppDatabase.instance.db;
    return await db.rawInsert(
      """
      insert into categoryproduct
      (category_product_name)
      values
      (?)
      """,
      [category_product.category_product_name],
    );
  }

  Future<List<Category_product>> queryCategoryProduct() async {
    final Database db = await AppDatabase.instance.db;
    final List<Map<String, Object?>> queryResult = await db.rawQuery(
      'select * from categoryproduct',
    );
    return queryResult
        .map((e) => Category_product.fromMap(e))
        .toList();
  }

  Future<int> updateCategoryProduct(
    Category_product category_product,
  ) async {
    final Database db = await AppDatabase.instance.db;
    return await db.rawUpdate(
      """
      update categoryproduct
      set category_product_name = ?
      where category_product_id = ?
      """,
      [
        category_product.category_product_name,
        category_product.category_product_id,
      ],
    );
  }

  Future deleteCategoryProduct(int category_product_id) async {
    final Database db = await AppDatabase.instance.db;
    await db.rawDelete(
      'delete from categoryproduct where category_product_id = ?',
      [category_product_id],
    );
  }
}
