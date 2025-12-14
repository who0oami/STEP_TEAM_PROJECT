import 'package:sqflite/sqflite.dart';
import 'package:step_app/model/branch.dart';
import 'package:step_app/vm/app_database.dart';

class BranchHandler {
  // 입력
  Future<int> insertBranch(Branch branch) async {
    final Database db =
        await AppDatabase.instance.db; // ✅ 여기만 변경
    return await db.rawInsert(
      """
      insert into branch
      (branch_name, branch_phone, branch_location, branch_lat, branch_lng)
      values
      (?,?,?,?,?)
      """,
      [
        branch.branch_name,
        branch.branch_phone,
        branch.branch_location,
        branch.branch_lat,
        branch.branch_lng,
      ],
    );
  }

  // 검색
  Future<List<Branch>> queryBranch() async {
    final Database db =
        await AppDatabase.instance.db; // ✅ 여기만 변경
    final List<Map<String, Object?>> queryResult =
        await db.rawQuery('select * from branch');
    return queryResult
        .map((e) => Branch.fromMap(e))
        .toList();
  }

  // 수정
  Future<int> updateBranch(Branch branch) async {
    final Database db =
        await AppDatabase.instance.db; // ✅ 여기만 변경
    return await db.rawUpdate(
      """
      update branch
      set branch_name = ?, branch_phone = ?, branch_location = ?, branch_lat = ?, branch_lng = ?
      where branch_id = ?
      """,
      [
        branch.branch_name,
        branch.branch_phone,
        branch.branch_location,
        branch.branch_lat,
        branch.branch_lng,
        branch.branch_id,
      ],
    );
  }

  // 삭제
  Future<int> deleteBranch(int branch_id) async {
    final Database db =
        await AppDatabase.instance.db; // ✅ 여기만 변경
    return await db.rawDelete(
      'delete from branch where branch_id = ?',
      [branch_id],
    );
  }
}
