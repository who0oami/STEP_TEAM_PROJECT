import 'package:flutter/material.dart';

class ProductListSneakers extends StatefulWidget {
  const ProductListSneakers({super.key});

  @override
  State<ProductListSneakers> createState() =>
      _ProductListSneakersState();
}

class _ProductListSneakersState
    extends State<ProductListSneakers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SNEAKERS')),

      body: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  // Image.asset(),
                  Text(
                    'product name',
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    '(W)어그 타스만 2 체스트 넛',
                    style: TextStyle(
                      fontSize: 12,
                      color: const Color.fromARGB(
                        206,
                        23,
                        23,
                        23,
                      ),
                    ),
                  ),
                  Text('product price 원'),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Column(
                children: [
                  // Image.asset(),
                  Text(
                    'product name',
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    '(W)어그 타스만 2 체스트 넛',
                    style: TextStyle(
                      fontSize: 12,
                      color: const Color.fromARGB(
                        206,
                        23,
                        23,
                        23,
                      ),
                    ),
                  ),
                  Text('product price 원'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
