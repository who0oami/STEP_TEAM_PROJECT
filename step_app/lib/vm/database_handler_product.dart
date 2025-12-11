import 'package:sqflite/sqflite.dart';
import 'package:step_app/model/product.dart';

class ProductHandler {
  final Database db;
  ProductHandler(this.db);

  // CREATE
  Future<int> insertProduct(Product p) async =>
      await db.insert('Product', {
        'category_product_id': p.category_product_id,
        'category_manufacturer_id': p.category_manufacturer_id,
        'category_product_size_id': p.category_product_size_id,
        'category_color_id': p.category_color_id,
        'product_price': p.product_price,
        'product_quantity': p.product_quantity,
      });

  // READ ONE
  Future<Product?> getProduct(int id) async {
    final maps = await db.query(
      'Product',
      where: 'product_id=?',
      whereArgs: [id],
    );
    return maps.isNotEmpty ? Product.fromMap(maps.first) : null;
  }

  // READ ALL
  Future<List<Product>> getAllProducts() async {
    final maps = await db.query('Product');
    return maps.map((m) => Product.fromMap(m)).toList();
  }

  // UPDATE
  Future<int> updateProduct(Product p) async => await db.update(
    'Product',
    {
      'category_product_id': p.category_product_id,
      'category_manufacturer_id': p.category_manufacturer_id,
      'category_product_size_id': p.category_product_size_id,
      'category_color_id': p.category_color_id,
      'product_price': p.product_price,
      'product_quantity': p.product_quantity,
    },
    where: 'product_id=?',
    whereArgs: [p.product_id],
  );

  // DELETE
  Future<int> deleteProduct(int id) async => await db.delete(
    'Product',
    where: 'product_id=?',
    whereArgs: [id],
  );
}
