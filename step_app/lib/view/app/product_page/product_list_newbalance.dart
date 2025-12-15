import 'package:flutter/material.dart';
import 'package:step_app/vm/database_handler_product.dart';
import 'package:step_app/vm/seeds/seed_product.dart';

final List<String> newImages = [
  'images/new01.png',
  'images/new02.png',
  'images/new03.png',
  'images/new04.png',
  'images/new05.png',
  'images/new06.png',
  'images/new07.png',
  'images/new08.png',
  'images/new09.png',
  'images/new10.png',
  'images/new11.png',
  'images/new12.png',
  'images/new13.png',
  'images/new14.png',
  'images/new15.png',
  'images/new16.png',
];

class ProductListNewbalance extends StatefulWidget {
  const ProductListNewbalance({super.key});

  @override
  State<ProductListNewbalance> createState() => _ProductListNewbalanceState();
}

class _ProductListNewbalanceState extends State<ProductListNewbalance> {
  //property
  final DatabaseHandlerProduct handler = DatabaseHandlerProduct();

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
    final result = await handler.queryProductsByManufacturer(
      2,
    ); //2 = new balance

    setState(() {
      products = result;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (products.isEmpty) {
      return Scaffold(
        body: Center(
          child: Text(
            '등록된 New Balance 상품이 없습니다',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('NEW BALANCE', style: TextStyle(fontSize: 28)),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (context, index) {
            final product = products[index];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    child: Center(
                      child: Image.asset(
                        newImages[index % newImages.length],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 6),

                Text(
                  'New Balance',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),

                Text(
                  '사이즈 ${product['category_size_id']}',
                  style: TextStyle(fontSize: 13),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Text(
                    '가격 : ${product['product_price']}원',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                ),

                // Text(
                //   '컬러 : ${product['category_color_id']}',
                //   style: TextStyle(fontSize: 12),
                // ),
              ],
            );
          },
        ),
      ),
    );
  }
}
