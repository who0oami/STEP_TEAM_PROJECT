import 'package:step_app/model/category_manufacturer.dart';
import 'package:step_app/vm/database_handler_category_manufacturer.dart';

// seed_category_manufacturer.dart
class SeedCategoryManufacturer {
  // ✅ 앱 실행 중 1회만
  static bool _inserted = false;

  static Future<void> insertSeed() async {
    if (_inserted) return;

    final handler = CategoryManufacturerHandler();

    final List<Category_manufacturer>
    seedCategoryManufacturers = [
      Category_manufacturer(
        category_manufacturer_name: 'NIKE',
      ),
      Category_manufacturer(
        category_manufacturer_name: 'ADIDAS',
      ),
      Category_manufacturer(
        category_manufacturer_name: 'NEW BALANCE',
      ),
      Category_manufacturer(
        category_manufacturer_name: 'PUMA',
      ),
      Category_manufacturer(
        category_manufacturer_name: 'CONVERSE',
      ),
    ];

    for (final m in seedCategoryManufacturers) {
      await handler.insertCategoryManufacturer(m);
    }

    _inserted = true;
  }
}

// seed_category_manufacturer.dart

// class SeedCategoryManufacturer {
//   static Future<void> insertSeed(Database db) async {
//     for (final m in seedCategoryManufacturers) {
//       await db.insert(
//         'categorymanufacturer',
//         {
//           'category_manufacturer_id':
//               m.category_manufacturer_id,
//           'category_manufacturer_name':
//               m.category_manufacturer_name,
//         },
//         conflictAlgorithm: ConflictAlgorithm.ignore,
//       );
//     }
//   }
// }

// final List<Category_manufacturer>
// seedCategoryManufacturers = [
//   Category_manufacturer(
//     category_manufacturer_id: 1,
//     category_manufacturer_name: 'NIKE',
//   ),
//   Category_manufacturer(
//     category_manufacturer_id: 2,
//     category_manufacturer_name: 'ADIDAS',
//   ),
//   Category_manufacturer(
//     category_manufacturer_id: 3,
//     category_manufacturer_name: 'NEW BALANCE',
//   ),
//   Category_manufacturer(
//     category_manufacturer_id: 4,
//     category_manufacturer_name: 'PUMA',
//   ),
//   Category_manufacturer(
//     category_manufacturer_id: 5,
//     category_manufacturer_name: 'CONVERSE',
//   ),
// ];
