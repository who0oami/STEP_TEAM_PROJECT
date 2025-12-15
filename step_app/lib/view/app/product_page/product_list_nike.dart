import 'package:flutter/material.dart';
import 'package:step_app/view/app/detail_page.dart';
import 'package:step_app/vm/database_handler_product.dart';
import 'package:step_app/vm/seeds/seed_product.dart';

final List<String> nikeImages = [
  'images/nike01.png',
  'images/nike02.png',
  'images/nike03.png',
  'images/nike04.png',
  'images/nike05.png',
  'images/nike06.png',
  'images/nike07.png',
  'images/nike08.png',
  'images/nike09.png',
  'images/nike10.png',
  'images/nike11.png',
];

class ProductListNike extends StatefulWidget {
  const ProductListNike({super.key});

  @override
  State<ProductListNike> createState() =>
      _ProductListNikeState();
}

class _ProductListNikeState
    extends State<ProductListNike> {
  final DatabaseHandlerProduct handler =
      DatabaseHandlerProduct();

  List<Map<String, dynamic>> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    // ✅ seed 먼저 (1회만 실행되게 만드는 게 이상적이지만,
    // 발표용이라 그냥 호출해도 됨)
    await SeedProduct.insertSeed();

    // ✅ 그 다음 로드
    await loadProducts();
  }

  Future<void> loadProducts() async {
    final result = await handler
        .queryProductsByManufacturer(1); // 1 = NIKE

    setState(() {
      products = result;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (products.isEmpty) {
      return Scaffold(
        body: Center(
          child: Text(
            '등록된 NIKE 상품이 없습니다',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('NIKE'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.7,
              ),
          itemBuilder: (context, index) {
            final product = products[index];

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (__) =>
                        DetailPage(), //product: product
                  ),
                );
              },
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Image.asset(
                          nikeImages[index %
                              nikeImages.length],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 6),

                  Text(
                    'NIKE',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    '사이즈 ${product['product_size_id']}',
                    style: TextStyle(fontSize: 13),
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      0,
                      0,
                      0,
                      20,
                    ),
                    child: Text(
                      '가격 : ${product['product_price']}원',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  // Text(
                  //   '컬러 : ${product['category_color_id']}',
                  //   style: TextStyle(fontSize: 12),
                  // ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
