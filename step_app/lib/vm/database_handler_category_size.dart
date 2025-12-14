import 'package:sqflite/sqflite.dart';

import 'package:step_app/model/category_size.dart';
import 'package:step_app/vm/app_database.dart';

class CategorySizeHandler {
  // Connection 및 Table Creation

  // 입력
  Future<int> insertCategorySize(Category_size category_size) async {
    int result = 0;
    final Database db = await AppDatabase.instance.db;
    result = await db.rawInsert(
      """
      insert into categorysize
      (category_size_name)
      values
      (?)
      """,
      [category_size.category_size_name],
    );
    return result;
  } // insertCategorySize

  // 검색
  Future<List<Category_size>> queryCategorySize() async {
    final Database db = await AppDatabase.instance.db;
    final List<Map<String, Object?>> queryResult = await db.rawQuery(
      'select * from categorysize',
    );
    return queryResult.map((e) => Category_size.fromMap(e)).toList();
  } // queryCategorySize

  // 수정
  Future<int> updateCategorySize(Category_size category_size) async {
    int result = 0;
    final Database db = await AppDatabase.instance.db;
    result = await db.rawUpdate(
      """
      update categorysize
      set category_size_name = ?
      where category_size_id = ?
      """,
      [
        category_size.category_size_name,
        category_size.category_size_id,
      ],
    );

    return result;
  } // updateCategorySize

  // 삭제
  Future deleteCategorySize(int category_size_id) async {
    final Database db = await AppDatabase.instance.db;
    await db.rawDelete(
      'delete from categorysize where category_size_id = ?',
      [category_size_id],
    );
  } // deleteCategorySize
} // class
