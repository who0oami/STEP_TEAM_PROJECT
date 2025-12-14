import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:step_app/util/scolor.dart';

// class PColor {
//   static const Color appBarBackgroundColor = Colors.white;
//   static const Color appBarForegroundColor = Colors.black;
//   static const Color buttonPrimary = Colors.black;
//   static const Color buttonTextColor = Colors.white;
//   static const Color indicatorColor = Colors.black;
// }

class Product {
  final int? product_id; // 제품 번호_자동 증가 Primary Key
  // final String category_product_id; // 제품 카테고리 id
  final String category_manufacturer_id; // 제조사 카테고리 id
  final String category_product_size_id; // 사이즈 카테고리 id
  final String category_color_id; // 색상 카테고리 id
  final double product_price; // 제품 가격
  final int product_quantity; // 제품 수량
  final Uint8List product_image; // 제품 이미지
  Product({
    this.product_id,
    // required this.category_product_id,
    required this.category_manufacturer_id,
    required this.category_product_size_id,
    required this.category_color_id,
    required this.product_price,
    required this.product_quantity,
    required this.product_image,
  });
}

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  late List<Product> productList;
  late Product selectedProduct;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);

    productList = [
      Product(
        product_id: 1,
        // category_product_id: '001',
        category_manufacturer_id: 'Nike',
        category_product_size_id: '270',
        category_color_id: 'Black',
        product_price: 100.0,
        product_quantity: 10,
        product_image: Uint8List.fromList([]),
      ),
      Product(
        product_id: 2,
        // category_product_id: '002',
        category_manufacturer_id: 'Nike',
        category_product_size_id: '265',
        category_color_id: 'Black',
        product_price: 110.0,
        product_quantity: 15,

        product_image: Uint8List.fromList([]),
      ),
      Product(
        product_id: 3,
        // category_product_id: '003',
        category_manufacturer_id: 'Nike',
        category_product_size_id: '280',
        category_color_id: 'Black',
        product_price: 120.0,
        product_quantity: 20,
        product_image: Uint8List.fromList([]),
      ),
      Product(
        product_id: 4,
        // category_product_id: '004',
        category_manufacturer_id: 'Nike',
        category_product_size_id: '250',
        category_color_id: 'Black',
        product_price: 130.0,
        product_quantity: 25,
        product_image: Uint8List.fromList([]),
      ),
    ];

    selectedProduct = productList.first;
  }

  void _selectProduct(Product product) {
    selectedProduct = product;
    setState(() {});
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double horizontalPadding = 16.0;

    return Scaffold(
      backgroundColor: PColor.baseBackgroundColor,
      appBar: AppBar(
        backgroundColor: PColor.appBarBackgroundColor,
        foregroundColor: PColor.appBarForegroundColor,
        elevation: 0,

        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          IconButton(icon: Icon(Icons.favorite_border), onPressed: () {}),
          IconButton(icon: Icon(Icons.share_outlined), onPressed: () {}),
        ],

        bottom: TabBar(
          controller: controller,
          labelColor: PColor.appBarForegroundColor,
          indicatorColor: PColor.buttonPrimary,
          tabs: [
            Tab(text: '상품'),
            Tab(text: '사이즈'),
            Tab(text: '상세'),
          ],
        ),
      ),

      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: controller,
              children: [
                _buildProductTab(horizontalPadding),
                Center(child: Text("사이즈 선택 화면")),
                Center(child: Text("상세 정보 화면")),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.all(horizontalPadding),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: PColor.buttonPrimary,
                  foregroundColor: PColor.buttonTextColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  '구매하기',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductTab(double padding) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            // Center(
            //   child: Image.asset(
            //     selectedShoe.imageUrl,
            //     height: 300,
            //     fit: BoxFit.contain,
            //   ),
            // ),
            Center(
              child: Container(
                height: 300,
                color: Colors.grey[300],
                child: Center(
                  child: Text(
                    "상품 이미지 없음",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            SizedBox(
              height: 70,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  final product = productList[index];
                  return GestureDetector(
                    onTap: () => _selectProduct(product),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: SizedBox(
                        width: 70,
                        height: 70,
                        // decoration: BoxDecoration(
                        //   color: Colors.grey[200],
                        //   borderRadius: BorderRadius.circular(4),
                        //   border: Border.all(
                        //     color: selectedProduct == product
                        //         ? product.category_color_id == 'Black'
                        //               ? Colors.black
                        //               : Colors.red
                        //         : Colors.grey.shade300,
                        //     width: selectedProduct == product ? 3 : 1,
                        //   ),
                        // ),
                        child: Center(
                          child: SizedBox(
                            width: 30,
                            height: 30,
                            // decoration: BoxDecoration(
                            //   color: product.category_color_id == 'Black'
                            //       ? Colors.black
                            //       : Colors.red,
                            //   shape: BoxShape.circle,
                            // ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            //SizedBox(height: 40),
            Text(
              '발매가 ${selectedProduct.product_price}원',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            Text(
              '${selectedProduct.product_price}원',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 8),

            Text(
              selectedProduct.product_id.toString(),
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
            SizedBox(height: 4),

            // Text(
            //   '{manufacturer_category}:{product_category},',
            //   style: TextStyle(fontSize: 11, color: Colors.grey),
            // ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  /*
Future insertAction() async {
   Product product = Product(
      category_product_id: '1',2
      category_manufacturer_id: '1',
      category_product_size_id: '1',
      category_color_id: '1',
      product_price: 10000.0,
      product_quantity: 10,
      product_image: Uint8List(0),
    );
   */

  /*
//전체 상품 목록 조회   
SELECT * FROM product
//특정 상품 상세 조회   
SELECT * FROM product 
WHERE product_id = ?
////장바구니 추가   
///INSERT   INSERT INTO cart (customer_id, product_id, quantity)
///VALUES (?, ?, ?)
*/
}
