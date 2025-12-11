/*class DatabaseHandler {
  //Connection 및 Table Create
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'category_size.db'),
      onCreate: (db, version) async {
        await db.execute("""
          create table category_size(
            category_size_id integer primary key autoincrement,
            category_size_name text
          )
          """);
      },
      version: 1,
    );
  } //initialDB

  Future<int> insertCategory_size(
    Category_size category_size,
  ) async {
    int result = 0;
    final Database db = await initializeDB();
    result = await db.rawInsert(
      """
      insert into category_size
      (category_size_name)
      values
      (?)
      """,
      [category_size_name],
    ); //auto increment 생략
    return result;
  } 

  //검색
  Future<List<Category_size>> queryCategory_size() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db
        .rawQuery('select * from category_size');
    return queryResult
        .map((e) => Category_size.fromMap(e))
        .toList();
  } 

  // 수정
  Future<int> updateCategory_size(
    Category_size,
    category_size,
  ) async {
    int result = 0;
    final Database db = await initializeDB();
    result = await db.rawUpdate(
      """
      update Category_size
      set Category_size_name = ?
      where id = ?
      """,
      [category_size.name, category_size.id],
    ); //auto increment 생략
    return result;
  } 

  //삭제
  Future deleteCategory_size(int category_size) async {
    final Database db = await initializeDB();
    await db.rawDelete(
      'delete from category_size where id = ?',
      [id],
    );
  }
}
*/
