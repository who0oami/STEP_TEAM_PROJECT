import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:step_app/model/category_color.dart';

class CategoryColorHandler {
  /*
  ** Model 내용 
  int? category_color_id;
  String category_color_name;
  */
    
// Connection 및 Table Creation
  Future<Database> initializeDB() async{
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'step.db'),
      onCreate: (db, version) async{
        await db.execute(
          """
          create table categorycolor
          (
            category_color_id integer primary key autoincrement,
            category_color_name text
          )
          """
        );
      },
      version: 1,
    );
  } // initialDB

// 입력
  Future<int> insertCategorycolor(Category_color category_color) async{
    int result = 0;
    final Database db = await initializeDB();
    result = await db.rawInsert(
      """
      insert into categorycolor
      (category_color_name)
      values
      (?)
      """,
      [category_color.category_color_name]
    );
    return result;
  } // insertCategorycolor

  // 검색 
  Future<List<Category_color>> queryCategorycolor() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult =
        await db.rawQuery('select * from branch');
    return queryResult.map((e) => Category_color.fromMap(e)).toList();
  } // queryBranch

  // 수정 
  Future<int> updateCategorycolor(Category_color category_color) async{
    int result = 0;
    final Database db = await initializeDB();
    result = await db.rawUpdate(
      """
      update categorycolor
      set category_color_name = ?
      where category_color_id = ?
      """,
      [category_color.category_color_name, category_color.category_color_id]
    );

    return result;
  } // updateCategorycolor

  // 삭제
  Future deleteCategorycolor(int category_color_id) async {
    final Database db = await initializeDB();
    await db.rawDelete('delete from categorycolor where category_color_id = ?', [category_color_id]);
  } // deleteCategorycolor

} //class
