import 'package:sqflite/sqflite.dart';
import 'package:step_app/model/category_manufacturer.dart';

class CategoryManufacturerHandler {
  final Database db;
  CategoryManufacturerHandler(this.db);

  Future<int> insertCategoryManufacturer(
    Category_manufacturer m,
  ) async => await db.insert('Category_manufacturer', {
    'category_manufacturer_name': m.category_manufacturer_name,
  });

  Future<Category_manufacturer?> getCategoryManufacturer(
    int id,
  ) async {
    final maps = await db.query(
      'Category_manufacturer',
      where: 'category_manufacturer_id=?',
      whereArgs: [id],
    );
    return maps.isNotEmpty
        ? Category_manufacturer.fromMap(maps.first)
        : null;
  }

  Future<List<Category_manufacturer>>
  getAllCategoryManufacturers() async {
    final maps = await db.query('Category_manufacturer');
    return maps.map((m) => Category_manufacturer.fromMap(m)).toList();
  }

  Future<int> updateCategoryManufacturer(
    Category_manufacturer m,
  ) async => await db.update(
    'Category_manufacturer',
    {'category_manufacturer_name': m.category_manufacturer_name},
    where: 'category_manufacturer_id=?',
    whereArgs: [m.category_manufacturer_id],
  );

  Future<int> deleteCategoryManufacturer(int id) async =>
      await db.delete(
        'Category_manufacturer',
        where: 'category_manufacturer_id=?',
        whereArgs: [id],
      );
}
