import 'package:sqflite/sqflite.dart';
import 'package:step_app/model/category_product.dart';
import 'package:step_app/vm/app_database.dart';

class CategoryProductHandler {

  // INSERT
  Future<int> insertCategoryProduct(
    CategoryProduct categoryProduct,
  ) async {
    final Database db = await AppDatabase.instance.db;
    return await db.rawInsert(
      '''
      insert into categoryproduct
      (category_product_id, category_product_name)
      values (?, ?)
      ''',
      [
        categoryProduct.category_product_id,
        categoryProduct.category_product_name,
      ],
    );
  }

  // QUERY
  Future<List<CategoryProduct>> queryCategoryProduct() async {
    final Database db = await AppDatabase.instance.db;
    final List<Map<String, Object?>> queryResult =
        await db.rawQuery('select * from categoryproduct');

    return queryResult
        .map((e) => CategoryProduct.fromMap(e))
        .toList();
  }

  // UPDATE
  Future<int> updateCategoryProduct(
    CategoryProduct categoryProduct,
  ) async {
    final Database db = await AppDatabase.instance.db;
    return await db.rawUpdate(
      '''
      update categoryproduct
      set category_product_name = ?
      where category_product_id = ?
      ''',
      [
        categoryProduct.category_product_name,
        categoryProduct.category_product_id,
      ],
    );
  }

  // DELETE
  Future<void> deleteCategoryProduct(int category_product_id) async {
    final Database db = await AppDatabase.instance.db;
    await db.rawDelete(
      'delete from categoryproduct where category_product_id = ?',
      [category_product_id],
    );
  }
}
