import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:step_app/model/category_size.dart';

class CategorySizeHandler {
  /*
  ** Model 내용 
  int? category_size_id;
  String category_size_name;
  */
    
// Connection 및 Table Creation
  Future<Database> initializeDB() async{
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'step.db'),
      onCreate: (db, version) async{
        await db.execute(
          """
          create table categorysize
          (
            category_product_id integer primary key autoincrement,
            category_product_name text,
          )
          """
        );
      },
      version: 1,
    );
  } // initialDB

// 입력
  Future<int> insertCategorySize(Category_size category_size) async{
    int result = 0;
    final Database db = await initializeDB();
    result = await db.rawInsert(
      """
      insert into categorysize
      (category_product_name)
      values
      (?)
      """,
      [category_size.category_size_name]
    );
    return result;
  } // insertCategorySize

  // 검색 
  Future<List<Category_size>> queryCategorySize() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult =
        await db.rawQuery('select * from categorysize');
    return queryResult.map((e) => Category_size.fromMap(e)).toList();
  } // queryCategorySize

  // 수정 
  Future<int> updateCategorySize(Category_size category_size) async{
    int result = 0;
    final Database db = await initializeDB();
    result = await db.rawUpdate(
      """
      update categorysize
      set category_size_name = ?
      where category_size_id = ?
      """,
      [category_size.category_size_name, category_size.category_size_id]
    );

    return result;
  } // updateCategorySize

  // 삭제
  Future deleteCategorySize(int category_size_id) async {
    final Database db = await initializeDB();
    await db.rawDelete('delete from categorysize where category_size_id = ?', [category_size_id]);
  } // deleteCategorySize

} //class
