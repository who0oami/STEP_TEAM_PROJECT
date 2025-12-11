import 'package:step_app/model/manufacturer.dart';

import 'package:sqflite/sqflite.dart';

class ManufacturerHandler {
  final Database db;
  ManufacturerHandler(this.db);

  Future<int> insertManufacturer(Manufacturer m) async =>
      await db.insert('Manufacturer', {
        'manufacturer_name': m.manufacturer_name,
        'manufacturer_phone': m.manufacturer_phone,
      });

  Future<Manufacturer?> getManufacturer(int id) async {
    final maps = await db.query(
      'Manufacturer',
      where: 'manufacturer_id=?',
      whereArgs: [id],
    );
    return maps.isNotEmpty ? Manufacturer.fromMap(maps.first) : null;
  }

  Future<List<Manufacturer>> getAllManufacturers() async {
    final maps = await db.query('Manufacturer');
    return maps.map((m) => Manufacturer.fromMap(m)).toList();
  }

  Future<int> updateManufacturer(Manufacturer m) async =>
      await db.update(
        'Manufacturer',
        {
          'manufacturer_name': m.manufacturer_name,
          'manufacturer_phone': m.manufacturer_phone,
        },
        where: 'manufacturer_id=?',
        whereArgs: [m.manufacturer_id],
      );

  Future<int> deleteManufacturer(int id) async => await db.delete(
    'Manufacturer',
    where: 'manufacturer_id=?',
    whereArgs: [id],
  );
}
