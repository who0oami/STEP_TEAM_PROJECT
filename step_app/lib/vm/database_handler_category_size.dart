import 'package:sqflite/sqflite.dart';
import 'package:step_app/model/category_size.dart';

class CategorySizeHandler {
  final Database db;
  CategorySizeHandler(this.db);

  Future<int> insertCategorySize(Category_size s) async =>
      await db.insert('Category_size', {
        'category_size_name': s.category_size_name,
      });

  Future<Category_size?> getCategorySize(int id) async {
    final maps = await db.query(
      'Category_size',
      where: 'category_size_id=?',
      whereArgs: [id],
    );
    return maps.isNotEmpty ? Category_size.fromMap(maps.first) : null;
  }

  Future<List<Category_size>> getAllCategorySizes() async {
    final maps = await db.query('Category_size');
    return maps.map((m) => Category_size.fromMap(m)).toList();
  }

  Future<int> updateCategorySize(Category_size s) async =>
      await db.update(
        'Category_size',
        {'category_size_name': s.category_size_name},
        where: 'category_size_id=?',
        whereArgs: [s.category_size_id],
      );

  Future<int> deleteCategorySize(int id) async => await db.delete(
    'Category_size',
    where: 'category_size_id=?',
    whereArgs: [id],
  );
}
