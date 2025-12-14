import 'package:step_app/model/category_product.dart';
import 'package:step_app/vm/database_handler_category_product.dart';

class SeedCategoryProduct {
  final List<Category_product> productSeedData = [
    Category_product(category_product_name: '운동화'),
    Category_product(category_product_name: '스니커즈'),
    Category_product(category_product_name: '슬리퍼'),
  ];

  // DB에 삽입
  Future<void> insertSeedData() async {
    final dbHandler = CategoryProductHandler();

    for (var p in productSeedData) {
      await dbHandler.insertCategoryProduct(p);
    }
  }
}
