import 'dart:typed_data';
import 'package:step_app/model/product.dart';
import 'package:step_app/vm/database_handler_product.dart';

class SeedProduct {
  static Future<void> insertSeed() async {
    final dbHandler = DatabaseHandlerProduct();

    List<Product> products = [
      // =================
      // NIKE
      // =================
      Product(
        category_product_id: '1',
        category_manufacturer_id: '1',
        category_size_id: '250',
        category_color_id: '2', // WHITE
        product_price: 120000,
        product_quantity: 15,
        product_image: Uint8List(0),
      ),
      Product(
        category_product_id: '1',
        category_manufacturer_id: '1',
        category_size_id: '260',
        category_color_id: '1', // BLACK
        product_price: 125000,
        product_quantity: 10,
        product_image: Uint8List(0),
      ),

      // =================
      // ADIDAS
      // =================
      Product(
        category_product_id: '1',
        category_manufacturer_id: '2',
        category_size_id: '250',
        category_color_id: '4', // RED
        product_price: 110000,
        product_quantity: 12,
        product_image: Uint8List(0),
      ),
      Product(
        category_product_id: '1',
        category_manufacturer_id: '2',
        category_size_id: '265',
        category_color_id: '5', // BLUE
        product_price: 115000,
        product_quantity: 8,
        product_image: Uint8List(0),
      ),

      // =================
      // NEW BALANCE
      // =================
      Product(
        category_product_id: '1',
        category_manufacturer_id: '3',
        category_size_id: '255',
        category_color_id: '3', // GRAY
        product_price: 105000,
        product_quantity: 20,
        product_image: Uint8List(0),
      ),
      Product(
        category_product_id: '1',
        category_manufacturer_id: '3',
        category_size_id: '270',
        category_color_id: '1', // BLACK
        product_price: 110000,
        product_quantity: 7,
        product_image: Uint8List(0),
      ),

      // =================
      // PUMA
      // =================
      Product(
        category_product_id: '1',
        category_manufacturer_id: '4',
        category_size_id: '255',
        category_color_id: '6', // GREEN
        product_price: 98000,
        product_quantity: 14,
        product_image: Uint8List(0),
      ),
      Product(
        category_product_id: '1',
        category_manufacturer_id: '4',
        category_size_id: '265',
        category_color_id: '1', // BLACK
        product_price: 102000,
        product_quantity: 9,
        product_image: Uint8List(0),
      ),

      // =================
      // CONVERSE
      // =================
      Product(
        category_product_id: '1',
        category_manufacturer_id: '5',
        category_size_id: '250',
        category_color_id: '2', // WHITE
        product_price: 89000,
        product_quantity: 18,
        product_image: Uint8List(0),
      ),
      Product(
        category_product_id: '1',
        category_manufacturer_id: '5',
        category_size_id: '270',
        category_color_id: '7', // BROWN
        product_price: 92000,
        product_quantity: 11,
        product_image: Uint8List(0),
      ),
    ];

    for (var p in products) {
      await dbHandler.insertProduct(p);
    }

  }
}
