import 'dart:typed_data';
import 'package:step_app/model/product.dart';
import 'package:step_app/vm/database_handler_product.dart';

class SeedProduct {
  static Future<void> insertSeed() async {
    final dbHandler = DatabaseHandlerProduct();

    List<Product> products = [
      // Nike
      Product(
        category_product_id: '1',
        category_manufacturer_id: '1',
        category_product_size_id: '250',
        category_color_id: 'White',
        product_price: 120000,
        product_quantity: 15,
        product_image: Uint8List(0),
      ),
      Product(
        category_product_id: '1',
        category_manufacturer_id: '1',
        category_product_size_id: '260',
        category_color_id: 'Black',
        product_price: 125000,
        product_quantity: 10,
        product_image: Uint8List(0),
      ),

      // Adidas
      Product(
        category_product_id: '2',
        category_manufacturer_id: '2',
        category_product_size_id: '250',
        category_color_id: 'Red',
        product_price: 110000,
        product_quantity: 12,
        product_image: Uint8List(0),
      ),
      Product(
        category_product_id: '2',
        category_manufacturer_id: '2',
        category_product_size_id: '265',
        category_color_id: 'Blue',
        product_price: 115000,
        product_quantity: 8,
        product_image: Uint8List(0),
      ),

      // New Balance
      Product(
        category_product_id: '3',
        category_manufacturer_id: '3', 
        category_product_size_id: '255',
        category_color_id: 'Grey',
        product_price: 105000,
        product_quantity: 20,
        product_image: Uint8List(0),
      ),
      Product(
        category_product_id: '3',
        category_manufacturer_id: '3',
        category_product_size_id: '270',
        category_color_id: 'Black',
        product_price: 110000,
        product_quantity: 7,
        product_image: Uint8List(0),
      ),
    ];

    for (var p in products) {
      await dbHandler.insertProduct(p);
    }

  }
}
