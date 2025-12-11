/*class DatabaseHandler {
  //Connection 및 Table Create
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'category_color.db'),
      onCreate: (db, version) async {
        await db.execute("""
          create table category_color(
            category_color_id integer primary key autoincrement,
            category_color_name text
          )
          """);
      },
      version: 1,
    );
  } //initialDB

  Future<int> insertCategory_color(
    Category_color category_color,
  ) async {
    int result = 0;
    final Database db = await initializeDB();
    result = await db.rawInsert(
      """
      insert into category_color
      (category_color_name)
      values
      (?)
      """,
      [category_color_name],
    ); //auto increment 생략
    return result;
  } 

  //검색
  Future<List<Category_color>> queryCategory_color() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db
        .rawQuery('select * from category_color');
    return queryResult
        .map((e) => Category_color.fromMap(e))
        .toList();
  } 

  // 수정
  Future<int> updateCategory_color(
    Category_color,
    category_color,
  ) async {
    int result = 0;
    final Database db = await initializeDB();
    result = await db.rawUpdate(
      """
      update Category_color
      set Category_color_name = ?
      where id = ?
      """,
      [category_color.name, category_color.id],
    ); //auto increment 생략
    return result;
  } 

  //삭제
  Future deleteCategory_color(int category_color) async {
    final Database db = await initializeDB();
    await db.rawDelete(
      'delete from category_color where id = ?',
      [id],
    );
  }
}
*/
