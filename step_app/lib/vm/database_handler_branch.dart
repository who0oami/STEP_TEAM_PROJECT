import 'package:sqflite/sqflite.dart';
import 'package:step_app/model/branch.dart';

class BranchHandler {
  final Database db;
  BranchHandler(this.db);

  Future<int> insertBranch(Branch branch) async =>
      await db.insert('Branch', {
        'branch_name': branch.branch_name,
        'branch_phone': branch.branch_phone,
        'branch_location': branch.branch_location,
      });

  Future<Branch?> getBranch(int id) async {
    final maps = await db.query(
      'Branch',
      where: 'branch_id=?',
      whereArgs: [id],
    );
    return maps.isNotEmpty ? Branch.fromMap(maps.first) : null;
  }

  Future<List<Branch>> getAllBranches() async {
    final maps = await db.query('Branch');
    return maps.map((m) => Branch.fromMap(m)).toList();
  }

  Future<int> updateBranch(Branch branch) async => await db.update(
    'Branch',
    {
      'branch_name': branch.branch_name,
      'branch_phone': branch.branch_phone,
      'branch_location': branch.branch_location,
    },
    where: 'branch_id=?',
    whereArgs: [branch.branch_id],
  );

  Future<int> deleteBranch(int id) async => await db.delete(
    'Branch',
    where: 'branch_id=?',
    whereArgs: [id],
  );
}
