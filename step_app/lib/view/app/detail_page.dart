import 'package:flutter/material.dart';

class Shoes {
  final String name;
  final Color color;
  final int size;

  Shoes({
    required this.name,
    required this.color,
    required this.size,
  });
}

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>
    with SingleTickerProviderStateMixin {
  //property
  late TabController controller;
  late List<Shoes> shoesList;

  addShoes() {
    shoesList = [
      Shoes(name: '나이키 에어', color: Colors.red, size: 270),
      Shoes(
        name: '아디다스 부스트',
        color: Colors.blue,
        size: 265,
      ),
      Shoes(name: '뉴발란스', color: Colors.green, size: 280),
      Shoes(name: '컨버스', color: Colors.purple, size: 250),
    ];
  }

  @override
  void initState() {
    // TODO: implement initState
    controller = TabController(length: 3, vsync: this);
    shoesList = [];
    addShoes();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          //IconButton(icon: Icon(Icons.favorite_border), onPressed: () {}),
          //IconButton(icon: Icon(Icons.shopping_bag_outlined), onPressed: () {}),
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.more_horiz,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          controller: controller,
          tabs: [
            Tab(text: '상품'),
            Tab(text: '사이즈'),
            Tab(text: '상세'),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 40),
            Image.asset(
              'images/model.png',
              height: 250,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 100,
              child: Center(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: shoesList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(
                          //color: shoesList[index].color,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        // child: Text('Item $index'),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 40),
            Text('발매가 239,000원'),
            Text(
              '발매가 239,000원',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('조던 1 x 유니온 레트로 하이 DG 시카고 쉐도우'),
            Text('스니커즈*신발', style: TextStyle(fontSize: 11)),
          ],
        ),
      ),
    );
  }
}
