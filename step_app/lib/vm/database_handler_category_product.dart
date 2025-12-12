import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:step_app/model/category_product.dart';

class CategoryProductHandler {
  /*
  ** Model 내용 
  int? category_product_id;
  String category_product_name;
  */
    
// Connection 및 Table Creation
  Future<Database> initializeDB() async{
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'step.db'),
      onCreate: (db, version) async{
        await db.execute(
          """
          create table categoryproduct
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
  Future<int> insertCategoryProduct(Category_product category_product) async{
    int result = 0;
    final Database db = await initializeDB();
    result = await db.rawInsert(
      """
      insert into categoryproduct
      (category_product_name)
      values
      (?)
      """,
      [category_product.category_product_name]
    );
    return result;
  } // insertCategoryProduct

  // 검색 
  Future<List<Category_product>> queryCategoryProduct() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult =
        await db.rawQuery('select * from categoryproduct');
    return queryResult.map((e) => Category_product.fromMap(e)).toList();
  } // queryCategoryProduct

  // 수정 
  Future<int> updateCategoryProduct(Category_product category_product) async{
    int result = 0;
    final Database db = await initializeDB();
    result = await db.rawUpdate(
      """
      update categoryproduct
      set category_product_name = ?
      where category_product_id = ?
      """,
      [category_product.category_product_name, category_product.category_product_id]
    );

    return result;
  } // updateCategoryProduct

  // 삭제
  Future deleteCategoryProduct(int category_product_id) async {
    final Database db = await initializeDB();
    await db.rawDelete('delete from categoryproduct where category_product_id = ?', [category_product_id]);
  } // deleteCategoryProduct

} //class
