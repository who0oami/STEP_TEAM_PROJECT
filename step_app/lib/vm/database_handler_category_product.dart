import 'package:sqflite/sqflite.dart';
import 'package:step_app/model/category_product.dart';

class CategoryProductHandler {
  final Database db;
  CategoryProductHandler(this.db);

  Future<int> insertCategoryProduct(Category_product p) async =>
      await db.insert('Category_product', {
        'category_product_name': p.category_product_name,
      });

  Future<Category_product?> getCategoryProduct(int id) async {
    final maps = await db.query(
      'Category_product',
      where: 'category_product_id=?',
      whereArgs: [id],
    );
    return maps.isNotEmpty
        ? Category_product.fromMap(maps.first)
        : null;
  }

  Future<List<Category_product>> getAllCategoryProducts() async {
    final maps = await db.query('Category_product');
    return maps.map((m) => Category_product.fromMap(m)).toList();
  }

  Future<int> updateCategoryProduct(Category_product p) async =>
      await db.update(
        'Category_product',
        {'category_product_name': p.category_product_name},
        where: 'category_product_id=?',
        whereArgs: [p.category_product_id],
      );

  Future<int> deleteCategoryProduct(int id) async => await db.delete(
    'Category_product',
    where: 'category_product_id=?',
    whereArgs: [id],
  );
}
