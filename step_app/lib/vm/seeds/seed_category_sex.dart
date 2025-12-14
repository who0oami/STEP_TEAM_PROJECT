// import 'package:step_app/model/category_sex.dart';
// import 'package:step_app/vm/database_handler_category_sex.dart';

// // seed_category_sex.dart
// class SeedCategorySex {
//   static bool _inserted = false;

//   static Future<void> insertSeed() async {
//     if (_inserted) return;

//     final handler = CategorySexHandler();

//     final List<Category_sex> categorySexSeedData = [
//       Category_sex(category_sex_name: 'WOMEN'),
//       Category_sex(category_sex_name: 'MEN'),
//     ];

//     for (final sex in categorySexSeedData) {
//       await handler.insertCategorySex(sex);
//     }

//     _inserted = true;
//   }
// }
