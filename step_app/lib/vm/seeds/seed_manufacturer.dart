import 'package:step_app/model/manufacturer.dart';
import 'package:step_app/vm/database_handler_manufacturer.dart';

// seed_manufacturer.dart
class SeedManufacturer {
  static bool _inserted = false;

  static Future<void> insertSeed() async {
    if (_inserted) return;

    final handler = DatabaseHandlerManufacturer();

    final List<Manufacturer> seedManufacturers = [
      Manufacturer(
        // manufacturer_id: 1,
        manufacturer_name: 'NIKE',
        manufacturer_phone: '02-5786-1004',
      ),
      Manufacturer(
        // manufacturer_id: 2,
        manufacturer_name: 'ADIDAS',
        manufacturer_phone: '02-1256-2657',
      ),
      Manufacturer(
        // manufacturer_id: 3,
        manufacturer_name: 'NEW BALANCE',
        manufacturer_phone: '02-9274-2953',
      ),
      Manufacturer(
        // manufacturer_id: 4,
        manufacturer_name: 'PUMA',
        manufacturer_phone: '02-4938-3947',
      ),
      Manufacturer(
        // manufacturer_id: 5,
        manufacturer_name: 'CONVERSE',
        manufacturer_phone: '02-2846-3958',
      ),
    ];

    for (final m in seedManufacturers) {
      await handler.insertManufacturer(m);
    }

    _inserted = true;
  }
}
// import 'package:step_app/model/manufacturer.dart';
// import 'package:sqflite/sqflite.dart';

// class SeedManufacturer {
//   static Future<void> insertSeed(Database db) async {
//     for (final manufac in seedManufacturers) {
//       await db.insert(
//         'manufacturer',
//         {
//           'manufacturer_id': manufac.manufacturer_id,
//           'manufacturer_name': manufac.manufacturer_name,
//           'manufacturer_phone':
//               manufac.manufacturer_phone,
//         },
//         conflictAlgorithm: ConflictAlgorithm.ignore,
//       );
//     }
//   }
// }

// final List<Manufacturer> seedManufacturers = [
//   Manufacturer(
//     manufacturer_id: 1,
//     manufacturer_name: 'NIKE',
//     manufacturer_phone: '02-5786-1004',
//   ),
//   Manufacturer(
//     manufacturer_id: 2,
//     manufacturer_name: 'ADIDAS',
//     manufacturer_phone: '02-1256-2657',
//   ),
//   Manufacturer(
//     manufacturer_id: 3,
//     manufacturer_name: 'NEW BALANCE',
//     manufacturer_phone: '02-9274-2953',
//   ),
//   Manufacturer(
//     manufacturer_id: 4,
//     manufacturer_name: 'PUMA',
//     manufacturer_phone: '02-4938-3947',
//   ),
//   Manufacturer(
//     manufacturer_id: 5,
//     manufacturer_name: 'CONVERSE',
//     manufacturer_phone: '02-2846-3958',
//   ),
// ];
