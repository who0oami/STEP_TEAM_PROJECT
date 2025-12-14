import 'package:step_app/model/category_color.dart';
import 'package:step_app/vm/database_handler_category_color.dart';

class SeedCategoryColor {
  // ✅ 앱 실행 중 1회만
  static bool _inserted = false;

  static Future<void> insertSeed() async {
    if (_inserted) return;

    final handler = CategoryColorHandler();

    final List<Category_color> seedCategoryColors = [
      Category_color(category_color_name: 'BLACK'),
      Category_color(category_color_name: 'WHITE'),
      Category_color(category_color_name: 'GRAY'),
      Category_color(category_color_name: 'RED'),
      Category_color(category_color_name: 'BLUE'),
      Category_color(category_color_name: 'GREEN'),
      Category_color(category_color_name: 'BROWN'),
    ];

    for (final c in seedCategoryColors) {
      await handler.insertCategorycolor(c);
    }

    _inserted = true;
  }
}

// import 'package:step_app/model/category_color.dart';
// import 'package:sqflite/sqflite.dart';

// class SeedCategoryColor {
//   static Future<void> insertSeed(Database db) async {
//     for (final c in seedCategoryColors) {
//       await db.insert(
//         'categorycolor',
//         {
//           'category_color_id': c.category_color_id,
//           'category_color_name': c.category_color_name,
//         },
//         conflictAlgorithm: ConflictAlgorithm.replace,
//       );
//     }
//   }
// }

// final List<Category_color> seedCategoryColors = [
//   Category_color(
//     category_color_id: 1,
//     category_color_name: 'BLACK',
//   ),
//   Category_color(
//     category_color_id: 2,
//     category_color_name: 'WHITE',
//   ),
//   Category_color(
//     category_color_id: 3,
//     category_color_name: 'GRAY',
//   ),
//   Category_color(
//     category_color_id: 4,
//     category_color_name: 'RED',
//   ),
//   Category_color(
//     category_color_id: 5,
//     category_color_name: 'BLUE',
//   ),
//   Category_color(
//     category_color_id: 6,
//     category_color_name: 'GREEN',
//   ),
//   Category_color(
//     category_color_id: 7,
//     category_color_name: 'BROWN',
//   ),
// ];
