import 'package:step_app/model/category_size.dart';
import 'package:step_app/vm/database_handler_category_size.dart';

// seed_category_size.dart
class SeedCategorySize {
  static bool _inserted = false;

  static Future<void> insertSeed() async {
    if (_inserted) return;

    final handler = CategorySizeHandler();

    final List<Category_size> categorySizeSeedData = [];

    // 210 ~ 320, 5단위
    for (int size = 210; size <= 320; size += 5) {
      categorySizeSeedData.add(
        Category_size(
          category_size_name: size.toString(),
        ),
      );
    }

    for (final c in categorySizeSeedData) {
      await handler.insertCategorySize(c);
    }

    _inserted = true;
  }
}

// import 'package:step_app/model/category_size.dart';
// import 'package:step_app/vm/database_handler_category_size.dart';

// class SeedCategorySize {
//   // 5 단위
//   final List<Category_size> categorySizeSeedData = [];

//   SeedCategorySize() {
//     for (int size = 210; size <= 320; size += 5) {
//       categorySizeSeedData.add(Category_size(category_size_name: size.toString()));
//     }
//   }

//   // DB에 삽입
//   Future<void> insertSeedData() async {
//     final dbHandler = CategorySizeHandler();

//     for (var c in categorySizeSeedData) {
//       await dbHandler.insertCategorySize(c);
//     }
//   }
// }
