import 'package:sqflite/sqflite.dart';
import 'package:step_app/model/product.dart';
import 'package:step_app/vm/app_database.dart';

class DatabaseHandlerProduct {
  // =====================
  // INSERT
  // =====================
  Future<int> insertProduct(Product product) async {
    final Database db = await AppDatabase.instance.db;
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
    final Database db = await AppDatabase.instance.db;
    final List<Map<String, Object?>> result = await db
        .rawQuery('select * from product');

    return result.map((e) => Product.fromMap(e)).toList();
  }

  //query(이름, 카테고리 조회)
  Future<List<Map<String, dynamic>>>
  querySneakersWithInfo() async {
    final db = await AppDatabase.instance.db;
    final result = await db.rawQuery('''
  SELECT
    p.product_id,
    p.product_price,
    p.product_quantity,

    m.category_manufacturer_name AS manufacturer_name,
    c.category_color_name AS color_name,
    cp.category_product_name AS product_name

  FROM product p
  JOIN categorymanufacturer m
    ON p.category_manufacturer_id = m.category_manufacturer_id
  JOIN categorycolor c
    ON p.category_color_id = c.category_color_id
  JOIN categoryproduct cp
    ON p.category_product_id = cp.category_product_id

  WHERE p.category_product_id = 2
''');

    return result;
  }

  // =====================
  // QUERY (ID로 조회)
  // =====================
  Future<Product?> getProductById(int id) async {
    final Database db = await AppDatabase.instance.db;
    final result = await db.rawQuery(
      'select * from product where product_id = ?',
      [id],
    );

    if (result.isEmpty) return null;
    return Product.fromMap(result.first);
  }

  // 카테고리 조회
  Future<List<Product>> queryProductsByCategory(
    int categoryId,
  ) async {
    final db = await AppDatabase.instance.db;

    final List<Map<String, dynamic>> result = await db
        .rawQuery(
          '''
    SELECT * FROM product
    WHERE category_product_id = ?
    ''',
          [categoryId],
        );

    return result.map((e) => Product.fromMap(e)).toList();
  }

  // =====================
  // UPDATE
  // =====================
  Future<int> updateProduct(Product product) async {
    final Database db = await AppDatabase.instance.db;

    if (product.product_id == null) {
      throw Exception(
        'product_id가 없는 데이터는 update 할 수 없습니다.',
      );
    }

    return await db.rawUpdate(
      '''
      update product
      set
        category_product_id = ?,
        category_manufacturer_id = ?,
        category_size_id = ?,
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
    final Database db = await AppDatabase.instance.db;
    return await db.rawDelete(
      'delete from product where product_id = ?',
      [product_id],
    );
  }
}
