import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:step_app/model/category_sex.dart';

class DatabaseHandlerCategorySex {
  Future<Database> initializedDB() async {
    final String path = await getDatabasesPath();

    return openDatabase(
      join(path, 'step.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          create table category_sex (
            category_sex_id integer primary key,
            category_sex_name text not null
          )
        ''');

        // ✅ 초기 데이터 (여성 / 남성)
        await db.insert('category_sex', {
          'category_sex_id': 1,
          'category_sex_name': 'WOMEN',
        });

        await db.insert('category_sex', {
          'category_sex_id': 2,
          'category_sex_name': 'MEN',
        });
      },
    );
  }

  // =====================
  // Query (전체 조회)
  // =====================
  Future<List<Category_sex>> queryCategorySex() async {
    final db = await initializedDB();
    final result = await db.rawQuery(
      'select * from category_sex order by category_sex_id',
    );
    return result.map((e) => Category_sex.fromMap(e)).toList();
  }

  // =====================
  // Query (ID로 조회)
  // =====================
  Future<Category_sex?> getCategorySexById(int category_id) async {
    final db = await initializedDB();
    final result = await db.rawQuery(
      'select * from category_sex where category_sex_id = ?',
      [category_id],
    );

    if (result.isEmpty) return null;
    return Category_sex.fromMap(result.first);
  }
}
