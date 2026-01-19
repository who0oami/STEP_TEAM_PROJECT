import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:step_app/util/scolor.dart'; 

class Product {
  final int? product_id;
  final String category_manufacturer_id;
  final String category_product_size_id;
  final String category_color_id;
  final double product_price;
  final int product_quantity;
  final Uint8List product_image;

  Product({
    this.product_id,
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

class _DetailPageState extends State<DetailPage> with SingleTickerProviderStateMixin {
  late TabController controller;
  late List<Product> productList;
  late Product selectedProduct;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);

    productList = [
      Product(
        product_id: 10123,
        category_manufacturer_id: 'Nike',
        category_product_size_id: '270',
        category_color_id: 'Black',
        product_price: 129000,
        product_quantity: 10,
        product_image: Uint8List.fromList([]),
      ),
      Product(
        product_id: 10124,
        category_manufacturer_id: 'Nike',
        category_product_size_id: '265',
        category_color_id: 'Red',
        product_price: 139000,
        product_quantity: 5,
        product_image: Uint8List.fromList([]),
      ),
      Product(
        product_id: 10125,
        category_manufacturer_id: 'Nike',
        category_product_size_id: '280',
        category_color_id: 'Grey',
        product_price: 125000,
        product_quantity: 20,
        product_image: Uint8List.fromList([]),
      ),
    ];

    selectedProduct = productList.first;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _selectProduct(Product product) {
    setState(() {
      selectedProduct = product;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PColor.baseBackgroundColor,
      appBar: AppBar(
        backgroundColor: PColor.appBarBackgroundColor,
        foregroundColor: PColor.appBarForegroundColor,
        elevation: 0,
        title: Text(selectedProduct.category_manufacturer_id),
        actions: [
          IconButton(icon: Icon(Icons.favorite_border), onPressed: () {}),
          IconButton(icon: Icon(Icons.share_outlined), onPressed: () {}),
        ],
        bottom: TabBar(
          controller: controller,
          indicatorColor: PColor.buttonPrimary,
          labelColor: PColor.appBarForegroundColor,
          tabs: const [
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
                _buildProductTab(),
              Center(child: Text("사이즈 정보 테이블")),
                 Center(child: Text("상세 설명 및 리뷰")),
              ],
            ),
          ),
          _buildBottomButton(),
        ],
      ),
    );
  }

  Widget _buildProductTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
    
          Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(12),
            ),
            child:  Icon(Icons.image, size: 100, color: Colors.grey),
          ),
          SizedBox(height: 20),
           Text("추천 옵션", style: TextStyle(fontWeight: FontWeight.bold)),
           SizedBox(height: 10),
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: productList.length,
              itemBuilder: (context, index) {
                final product = productList[index];
                bool isSelected = selectedProduct.product_id == product.product_id;

                return GestureDetector(
                  onTap: () => _selectProduct(product),
                  child: Container(
                    width: 80,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isSelected ? PColor.buttonPrimary : Colors.transparent,
                        width: 2,
                      ),
                      image: const DecorationImage(
                        image: NetworkImage("https://via.placeholder.com/80"), 
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
       SizedBox(height: 30),

          Text(
            selectedProduct.category_manufacturer_id,
            style: const TextStyle(fontSize: 16, color: Colors.grey, decoration: TextDecoration.underline),
          ),
        SizedBox(height: 8),
          Text(
            "Air Max Pulse - ${selectedProduct.category_color_id} Edition",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
         SizedBox(height: 20),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text("희망가", style: TextStyle(fontSize: 16)),
              Text(
                '${selectedProduct.product_price.toInt()}원',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Divider(height: 40),
          Text("상품 코드: ${selectedProduct.product_id}"),
          Text("선택 사이즈: ${selectedProduct.category_product_size_id} mm"),
          Text("재고 수량: ${selectedProduct.product_quantity} 개"),
        ],
      ),
    );
  }

  Widget _buildBottomButton() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, -2))],
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: PColor.buttonPrimary,
          foregroundColor: PColor.buttonTextColor,
          minimumSize: const Size(double.infinity, 55),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child:  Text('구매하기', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
