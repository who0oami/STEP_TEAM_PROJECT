import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:step_app/model/product.dart';

class DatabaseHandlerProduct {
  Future<Database> initializedDB() async {
    final String path = await getDatabasesPath();

    return openDatabase(
      join(path, 'step.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          create table product (
            product_id integer primary key autoincrement,
            category_product_id text not null,
            category_manufacturer_id text not null,
            category_product_size_id text not null,
            category_color_id text not null,
            product_price real not null,
            product_quantity integer not null,
            product_image blob not null
          )
        ''');
      },
    );
  }

  // =====================
  // INSERT
  // =====================
  Future<int> insertProduct(Product product) async {
    final db = await initializedDB();
    return await db.rawInsert(
      '''
      insert into product (
        category_product_id,
        category_manufacturer_id,
        category_product_size_id,
        category_color_id,
        product_price,
        product_quantity,
        product_image
      )
      values (?,?,?,?,?,?,?)
      ''',
      [
        product.category_product_id,
        product.category_manufacturer_id,
        product.category_product_size_id,
        product.category_color_id,
        product.product_price,
        product.product_quantity,
        product.product_image,
      ],
    );
  }

  // =====================
  // QUERY (전체 조회)
  // =====================
  Future<List<Product>> queryProduct() async {
    final db = await initializedDB();
    final List<Map<String, Object?>> result = await db.rawQuery(
      'select * from product',
    );

    return result.map((e) => Product.fromMap(e)).toList();
  }

  // =====================
  // QUERY (ID로 조회)
  // =====================
  Future<Product?> getProductById(int id) async {
    final db = await initializedDB();
    final result = await db.rawQuery(
      'select * from product where product_id = ?',
      [id],
    );

    if (result.isEmpty) return null;
    return Product.fromMap(result.first);
  }

  // =====================
  // UPDATE
  // =====================
  Future<int> updateProduct(Product product) async {
    final db = await initializedDB();

    if (product.product_id == null) {
      throw Exception('product_id가 없는 데이터는 update 할 수 없습니다.');
    }

    return await db.rawUpdate(
      '''
      update product
      set
        category_product_id = ?,
        category_manufacturer_id = ?,
        category_product_size_id = ?,
        category_color_id = ?,
        product_price = ?,
        product_quantity = ?,
        product_image = ?
      where product_id = ?
      ''',
      [
        product.category_product_id,
        product.category_manufacturer_id,
        product.category_product_size_id,
        product.category_color_id,
        product.product_price,
        product.product_quantity,
        product.product_image,
        product.product_id,
      ],
    );
  }

  // =====================
  // DELETE
  // =====================
  Future<int> deleteProduct(int product_id) async {
    final db = await initializedDB();
    return await db.rawDelete('delete from product where product_id = ?', [
      product_id,
    ]);
  }
}
