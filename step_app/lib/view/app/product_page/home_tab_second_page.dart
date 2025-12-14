import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_app/vm/database_handler_product.dart';

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

class HomeTabSecondPage extends StatefulWidget {
  const HomeTabSecondPage({super.key});

  @override
  State<HomeTabSecondPage> createState() =>
      _HomeTabSecondPageState();
}

class _HomeTabSecondPageState
    extends State<HomeTabSecondPage> {
  final DatabaseHandlerProduct handler =
      DatabaseHandlerProduct();

  List<Map<String, dynamic>> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  Future<void> loadProducts() async {
    final result = await handler
        .queryProductsSizeOver255();
    setState(() {
      products = result;
      isLoading = false;
    });
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
            '사이즈 255 이상 상품이 없습니다',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    return Scaffold(
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

            return GestureDetector(
              onTap: () {
                //
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
                        color: Colors.grey.shade200,
                      ),
                      child: Center(
                        child: Image.asset(
                          newImages[index %
                              newImages.length],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    manufacturerName(
                      product['category_manufacturer_id'],
                    ),
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '사이즈 ${product['category_size_id']}',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${product['product_price']}원',
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  } // build

  String manufacturerName(int id) {
    const map = {1: 'NIKE', 2: 'NEW BALANCE'};
    return map[id] ?? 'UNKNOWN';
  }
} // class
