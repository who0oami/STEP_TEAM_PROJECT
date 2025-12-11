/*class DatabaseHandler {
  //Connection 및 Table Create
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'category_product.db'),
      onCreate: (db, version) async {
        await db.execute("""
          create table category_product(
            category_product_id integer primary key autoincrement,
            category_product_name text
          )
          """);
      },
      version: 1,
    );
  } //initialDB

  Future<int> insertCategory_product(
    Category_product category_product,
  ) async {
    int result = 0;
    final Database db = await initializeDB();
    result = await db.rawInsert(
      """
      insert into category_product
      (category_product_name)
      values
      (?)
      """,
      [category_product_name],
    ); //auto increment 생략
    return result;
  } 

  //검색
  Future<List<Category_product>> queryCategory_product() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db
        .rawQuery('select * from category_product');
    return queryResult
        .map((e) => Category_product.fromMap(e))
        .toList();
  } 

  // 수정
  Future<int> updateCategory_product(
    Category_product,
    category_product,
  ) async {
    int result = 0;
    final Database db = await initializeDB();
    result = await db.rawUpdate(
      """
      update Category_product
      set Category_product_name = ?
      where id = ?
      """,
      [category_product.name, category_product.id],
    ); //auto increment 생략
    return result;
  } 

  //삭제
  Future deleteCategory_product(int category_product) async {
    final Database db = await initializeDB();
    await db.rawDelete(
      'delete from category_product where id = ?',
      [id],
    );
  }
}
*/
