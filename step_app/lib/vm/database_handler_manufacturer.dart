import 'package:sqflite/sqflite.dart';
import 'package:step_app/model/manufacturer.dart';
import 'package:step_app/vm/app_database.dart';

class DatabaseHandlerManufacturer {
  // Insert
  Future<int> insertManufacturer(Manufacturer manufacturer) async {
    int result = 0;
    final Database db = await AppDatabase.instance.db;
    result = await db.rawInsert(
      """insert into manufacturer
        (manufacturer_name, manufacturer_phone)
        values
        (?,?)
      """,
      [
        manufacturer.manufacturer_name,
        manufacturer.manufacturer_phone,
      ],
    );
    return result;
  }

  // Query
  Future<List<Manufacturer>> queryManufacturer() async {
    final Database db = await AppDatabase.instance.db;
    final List<Map<String, Object?>> queryResult = await db.rawQuery(
      """Select * from manufacturer""",
    );
    return queryResult.map((e) => Manufacturer.fromMap(e)).toList();
  }

  // Update
  Future<int> updateManufacturer(Manufacturer manufacturer) async {
    int result = 0;
    final Database db = await AppDatabase.instance.db;
    result = await db.rawUpdate(
      """
        update manufacturer
        set manufacturer_name = ?, manufacturer_phone =?
        where manufacturer_id = ?
      """,
      [
        manufacturer.manufacturer_name,
        manufacturer.manufacturer_phone,
        manufacturer.manufacturer_id,
      ], // 물음표 순서대로 맞춰야함
    );
    return result;
  }

  // Delete
  Future<void> deleteManufacturer(int Manufacturer_id) async {
    final Database db = await AppDatabase.instance.db;
    await db.rawDelete(
      """
      delete
      from manufacturer
      where manufacturer_id = ?
      """,
      [Manufacturer_id],
    );
  }
}
