// seed_category_manufacturer.dart
import 'package:step_app/model/category_manufacturer.dart';
import 'package:sqflite/sqflite.dart';

class SeedCategoryManufacturer {
  static Future<void> insertSeed(Database db) async {
    for (final m in seedCategoryManufacturers) {
      await db.insert(
        'categorymanufacturer',
        {
          'category_manufacturer_id':
              m.category_manufacturer_id,
          'category_manufacturer_name':
              m.category_manufacturer_name,
        },
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
  }
}

final List<Category_manufacturer>
seedCategoryManufacturers = [
  Category_manufacturer(
    category_manufacturer_id: 1,
    category_manufacturer_name: 'NIKE',
  ),
  Category_manufacturer(
    category_manufacturer_id: 2,
    category_manufacturer_name: 'ADIDAS',
  ),
  Category_manufacturer(
    category_manufacturer_id: 3,
    category_manufacturer_name: 'NEW BALANCE',
  ),
  Category_manufacturer(
    category_manufacturer_id: 4,
    category_manufacturer_name: 'PUMA',
  ),
  Category_manufacturer(
    category_manufacturer_id: 5,
    category_manufacturer_name: 'CONVERSE',
  ),
];
