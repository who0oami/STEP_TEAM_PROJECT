import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:step_app/model/branch.dart';

class BranchHandler {
  /*
  ** Model 내용 
  int? branch_id;
  String branch_name;
  String branch_phone;
  String branch_location;
  double branch_lat;
  double branch_lng;
  */
    
// Connection 및 Table Creation
  Future<Database> initializeDB() async{
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'step.db'),
      onCreate: (db, version) async{
        await db.execute(
          """
          create table branch
          (
            seq integer primary key autoincrement,
            branch_name text,
            branch_phone text,
            branch_location text,
            branch_lat real,
            branch_lat real
          )
          """
        );
      },
      version: 1,
    );
  } // initialDB

// 입력
  Future<int> insertBranch(Branch branch) async{
    int result = 0;
    final Database db = await initializeDB();
    result = await db.rawInsert(
      """
      insert into branch
      (branch_name, branch_phone, branch_location, branch_lat, branch_lat)
      values
      (?,?,?,?,?)
      """,
      [branch.branch_name, branch.branch_phone, branch.branch_lat, branch.branch_lng]
    );
    return result;
  } // insertPlace

  // 검색 
  Future<List<Branch>> queryBranch() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult =
        await db.rawQuery('select * from branch');
    return queryResult.map((e) => Branch.fromMap(e)).toList();
  } // queryBranch

  // 수정 
  Future<int> updateBranch(Branch branch) async{
    int result = 0;
    final Database db = await initializeDB();
    result = await db.rawUpdate(
      """
      update branch
      set branch_name = ?, branch_phone = ?, branch_location =?, branch_lat = ?, branch_lng = ?
      where branch_id = ?
      """,
      [branch.branch_name, branch.branch_phone, branch.branch_location, branch.branch_lat, branch.branch_lng, branch.branch_id]
    );

    return result;
  } // updateBranch

  // 삭제
  Future deleteBranch(int branch_id) async {
    final Database db = await initializeDB();
    await db.rawDelete('delete from branch where branch_id = ?', [branch_id]);
  } // deleteBranch

} //class
