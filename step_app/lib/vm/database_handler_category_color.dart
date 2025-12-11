import 'package:sqflite/sqflite.dart';
import 'package:step_app/model/category_color.dart';

class CategoryColorHandler {
  final Database db;
  CategoryColorHandler(this.db);

  Future<int> insertCategoryColor(Category_color color) async =>
      await db.insert('Category_color', {
        'category_color_name': color.category_color_name,
      });

  Future<Category_color?> getCategoryColor(int id) async {
    final maps = await db.query(
      'Category_color',
      where: 'category_color_id=?',
      whereArgs: [id],
    );
    return maps.isNotEmpty
        ? Category_color.fromMap(maps.first)
        : null;
  }

  Future<List<Category_color>> getAllCategoryColors() async {
    final maps = await db.query('Category_color');
    return maps.map((m) => Category_color.fromMap(m)).toList();
  }

  Future<int> updateCategoryColor(Category_color color) async =>
      await db.update(
        'Category_color',
        {'category_color_name': color.category_color_name},
        where: 'category_color_id=?',
        whereArgs: [color.category_color_id],
      );

  Future<int> deleteCategoryColor(int id) async => await db.delete(
    'Category_color',
    where: 'category_color_id=?',
    whereArgs: [id],
  );
}
