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
  Future<int> insertBranch(Category_size category_size) async{
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
  } // insertCategoryProduct

  // 검색 
  Future<List<Category_size>> queryCategoryProduct() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult =
        await db.rawQuery('select * from categoryproduct');
    return queryResult.map((e) => Category_size.fromMap(e)).toList();
  } // queryCategoryProduct

  // 수정 
  Future<int> updateCategoryProduct(Category_size category_size) async{
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
  } // updateCategoryProduct

  // 삭제
  Future deleteCategoryProduct(int category_product_id) async {
    final Database db = await initializeDB();
    await db.rawDelete('delete from categorysize where category_product_id = ?', [category_product_id]);
  } // deleteCategoryProduct

} //class
