import 'package:flutter/material.dart';
import 'package:step_app/vm/database_handler_product.dart';
import 'package:step_app/vm/seeds/seed_product.dart';

class ProductListSneakers extends StatefulWidget {
  const ProductListSneakers({super.key});

  @override
  State<ProductListSneakers> createState() =>
      _ProductListSneakersState();
}

class _ProductListSneakersState
    extends State<ProductListSneakers> {
  final DatabaseHandlerProduct handler =
      DatabaseHandlerProduct();

  List<Map<String, dynamic>> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Future<void> loadProducts() async {
      final result = await handler
          .queryProductsByManufacturer(1); // 1 = NIKE

      setState(() {
        products = result;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (products.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text(
            '등록된 스니커즈 상품이 없습니다',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('SNEAKERS'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.7,
              ),
          itemBuilder: (context, index) {
            final product = products[index];

            return Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                // 이미지 (지금은 더미)
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                      color: Colors.grey.shade200,
                    ),
                    child: const Center(
                      child: Text(
                        'IMAGE',
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 6),

                // ✅ 제품명
                // 제품명 (임시)
                Text(
                  'NIKE 상품',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // 제조사
                const Text(
                  'NIKE',
                  style: TextStyle(fontSize: 12),
                ),

                // 가격
                Text(
                  '${product['product_price']}원',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                // 컬러 ID (임시)
                Text(
                  '컬러 ID: ${product['category_color_id']}',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
