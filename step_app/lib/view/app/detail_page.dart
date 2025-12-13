import 'package:flutter/material.dart';

class PColor {
  static const Color appBarBackgroundColor = Colors.white;
  static const Color appBarForegroundColor = Colors.black;
  static const Color buttonPrimary = Colors.black;
  static const Color buttonTextColor = Colors.white;
  static const Color indicatorColor = Colors.black;
}

class Shoes {
  final String name;
  final Color color;
  final int size;
  //final String imageUrl;

  Shoes({
    required this.name,
    required this.color,
    required this.size,
    //required this.imageUrl,
  });
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  late List<Shoes> shoesList;
  late Shoes selectedShoe;

  @override
  void initState() {
    controller = TabController(length: 3, vsync: this);

    shoesList = [
      Shoes(
        name: '나이키 에어',
        color: Colors.red,
        size: 270,
        //imageUrl: 'images/AIR+FORCE+1.png',
      ),
      Shoes(
        name: '아디다스 부스트',
        color: Colors.blue,
        size: 265,
        //imageUrl: 'images/AIR+FORCE+2.png',
      ),
      Shoes(
        name: '뉴발란스',
        color: Colors.green,
        size: 280,
        //imageUrl: 'images/AIR+FORCE+3.png',
      ),
      Shoes(
        name: '컨버스',
        color: Colors.purple,
        size: 250,
        //imageUrl: 'images/AIR+FORCE+4.png',
      ),
    ];

    selectedShoe = shoesList.first;
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _selectShoe(Shoes shoe) {
    setState(() {
      selectedShoe = shoe;
    });
  }

  @override
  Widget build(BuildContext context) {
    const double horizontalPadding = 16.0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: PColor.appBarBackgroundColor,
        foregroundColor: PColor.appBarForegroundColor,
        elevation: 0,

        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.share_outlined),
            onPressed: () {},
          ),
        ],

        bottom: TabBar(
          controller: controller,
          labelColor: PColor.appBarForegroundColor,
          indicatorColor: PColor.indicatorColor,
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
            padding: const EdgeInsets.all(
              horizontalPadding,
            ),
            // decoration: BoxDecoration(
            //               color: Colors.white,
            //               boxShadow: [
            //                 BoxShadow(
            //                   color: Colors.grey.withOpacity(0.3),
            //                   spreadRadius: 1,
            //                   blurRadius: 5,
            //                   offset: const Offset(0, -1),
            //                 ),
            //               ],
            //             ),
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
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
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
                child: const Center(
                  child: Text(
                    "상품 이미지 없음",
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            SizedBox(
              height: 70,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: shoesList.length,
                itemBuilder: (context, index) {
                  final shoe = shoesList[index];
                  return GestureDetector(
                    onTap: () => _selectShoe(shoe),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 8.0,
                      ),
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius:
                              BorderRadius.circular(4),
                          border: Border.all(
                            color: selectedShoe == shoe
                                ? shoe.color
                                : Colors.grey.shade300,
                            width: selectedShoe == shoe
                                ? 3
                                : 1,
                          ),
                        ),
                        child: Center(
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: shoe.color,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            //SizedBox(height: 40),
            Text('발매가 239,000원'),
            Text(
              '248,000원',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 8),

            Text(
              selectedShoe.name,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 4),
            Text(
              '스니커즈*신발',
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey,
              ),
            ),

            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  /*
Future insertAction() async {
   Product product = Product(
      category_product_id: '1',
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
///INSERT	INSERT INTO cart (customer_id, product_id, quantity)
///VALUES (?, ?, ?)
*/
}
