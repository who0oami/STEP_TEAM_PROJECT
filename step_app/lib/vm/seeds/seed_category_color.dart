import 'package:step_app/model/category_color.dart';
import 'package:sqflite/sqflite.dart';

class SeedCategoryColor {
  static Future<void> insertSeed(Database db) async {
    for (final c in seedCategoryColors) {
      await db.insert(
        'categorycolor',
        {
          'category_color_id': c.category_color_id,
          'category_color_name': c.category_color_name,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }
}

final List<Category_color> seedCategoryColors = [
  Category_color(
    category_color_id: 1,
    category_color_name: 'BLACK',
  ),
  Category_color(
    category_color_id: 2,
    category_color_name: 'WHITE',
  ),
  Category_color(
    category_color_id: 3,
    category_color_name: 'GRAY',
  ),
  Category_color(
    category_color_id: 4,
    category_color_name: 'RED',
  ),
  Category_color(
    category_color_id: 5,
    category_color_name: 'BLUE',
  ),
  Category_color(
    category_color_id: 6,
    category_color_name: 'GREEN',
  ),
  Category_color(
    category_color_id: 7,
    category_color_name: 'BROWN',
  ),
];
