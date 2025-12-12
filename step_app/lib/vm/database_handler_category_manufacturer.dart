import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:step_app/model/category_manufacturer.dart';

class CategoryManufacturerHandler {
  /*
  ** Model 내용 
  int? category_manufacturer_id;
  String category_manufacturer_name;
  */
    
// Connection 및 Table Creation
  Future<Database> initializeDB() async{
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'step.db'),
      onCreate: (db, version) async{
        await db.execute(
          """
          create table categorymanufacturer
          (
            category_manufacturer_id integer primary key autoincrement,
            category_manufacturer_name text
          )
          """
        );
      },
      version: 1,
    );
  } // initialDB

// 입력
  Future<int> insertCategoryManufacturer(Category_manufacturer category_manufacturer) async{
    int result = 0;
    final Database db = await initializeDB();
    result = await db.rawInsert(
      """
      insert into categorymanufacturer
      (category_manufacturer_name)
      values
      (?)
      """,
      [category_manufacturer.category_manufacturer_name]
    );
    return result;
  } // insertCategoryManufacturer

  // 검색 
  Future<List<Category_manufacturer>> queryCategoryManufacturer() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult =
        await db.rawQuery('select * from categorymanufacturer');
    return queryResult.map((e) => Category_manufacturer.fromMap(e)).toList();
  } // queryCategoryManufacturer

  // 수정 
  Future<int> updateCategoryManufacturer(Category_manufacturer category_manufacturer) async{
    int result = 0;
    final Database db = await initializeDB();
    result = await db.rawUpdate(
      """
      update categorymanufacturer
      set category_manufacturer_name = ?
      where branch_id = ?
      """,
      [category_manufacturer.category_manufacturer_name, category_manufacturer.category_manufacturer_id]
    );

    return result;
  } // updateCategoryManufacturer

  // 삭제
  Future deleteCategoryManufacturer(int category_manufacturer_id) async {
    final Database db = await initializeDB();
    await db.rawDelete('delete from categorymanufacturer where category_manufacturer_id = ?', [category_manufacturer_id]);
  } // deleteCategoryManufacturer

} //class
