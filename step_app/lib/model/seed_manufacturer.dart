import 'package:step_app/model/manufacturer.dart';
import 'package:sqflite/sqflite.dart';

class SeedManufacturer {
  static Future<void> insertSeed(Database db) async {
    for (final manufac in seedManufacturers) {
      await db.insert(
        'manufacturer',
        {
          'manufacturer_name': manufac.manufacturer_name,
          'manufacturer_phone':
              manufac.manufacturer_phone,
        },
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
  }
}

final List<Manufacturer> seedManufacturers = [
  Manufacturer(
    manufacturer_name: 'NIKE',
    manufacturer_phone: '02-5786-1004',
  ),
  Manufacturer(
    manufacturer_name: 'ADIDAS',
    manufacturer_phone: '02-1256-2657',
  ),
  Manufacturer(
    manufacturer_name: 'NEW BALANCE',
    manufacturer_phone: '02-9274-2953',
  ),
  Manufacturer(
    manufacturer_name: 'PUMA',
    manufacturer_phone: '02-4938-3947',
  ),
  Manufacturer(
    manufacturer_name: 'CONVERSE',
    manufacturer_phone: '02-2846-3958',
  ),
];
