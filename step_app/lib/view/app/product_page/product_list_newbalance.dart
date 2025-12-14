import 'package:flutter/material.dart';

class ProductListNewbalance extends StatefulWidget {
  const ProductListNewbalance({super.key});

  @override
  State<ProductListNewbalance> createState() =>
      _ProductListNewbalanceState();
}

class _ProductListNewbalanceState
    extends State<ProductListNewbalance> {
  // 🔹 임시 더미 데이터 개수만큼
  final int itemCount = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SNEAKERS')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          itemCount:
              itemCount, // 데이터 삽입 후 products.length로 수정
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 한 줄에 2개
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.7, // 카드 비율
              ),
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                // 데이터 삽입 후 Image.memory(
                //   products[index].product_image,
                //   fit: BoxFit.cover,
                // )
                //  로 변경
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                      color: Colors.grey.shade300,
                    ),
                    child: Center(
                      child: Text(
                        'IMAGE',
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 6),

                // 🔹 제품명
                Text(
                  '(W) 어그 타스만 2 체스트 넛', // Text(products[index].product_name)
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                // 제조사 명
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    0,
                    3,
                    0,
                    0,
                  ),
                  child: Text(
                    '나이키',
                    style: TextStyle(fontSize: 12),
                  ),
                ), //Text('${products[index].product_price}원')
                Text(
                  '129,000원',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ), //Text('${products[index].product_price}원')
                // 컬러
                Text(
                  'White',
                  style: TextStyle(fontSize: 12),
                ), //Text('${products[index].product_price}원')
              ],
            );
          },
        ),
      ),
    );
  }
}
