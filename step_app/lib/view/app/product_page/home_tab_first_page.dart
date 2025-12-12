import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_app/view/app/product_page/product_list_boots.dart';
import 'package:step_app/view/app/product_page/product_list_slip.dart';
import 'package:step_app/view/app/product_page/product_list_sneakers.dart';

class HomeTabFirstPage extends StatefulWidget {
  const HomeTabFirstPage({super.key});

  @override
  State<HomeTabFirstPage> createState() =>
      _HomeTabFirstPageState();
}

class _HomeTabFirstPageState
    extends State<HomeTabFirstPage> {
  // property

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
        child: Column(
          children: [
            // 이미지 캐러셀(s)
            CarouselSlider(
              options: CarouselOptions(height: 450.0),
              items: [1, 2, 3].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(
                        context,
                      ).size.width,
                      margin: EdgeInsets.symmetric(
                        horizontal: 8.0,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF7B4BFF),
                        borderRadius:
                            BorderRadius.circular(10),
                      ),
                      child: Text(
                        'text $i',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    );
                  },
                );
              }).toList(),
            ), // 이미지 캐러셀(e)
            SizedBox(height: 30),
            SizedBox(
              height: 100,
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      // === 1번 아이콘 ===
                      GestureDetector(
                        onTap: () {
                          // print('sneakers 탭 클릭됨');
                          // Get.to(ProductListSneakers());
                        },
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/icon1.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          print('sneakers 탭 클릭됨');
                          Get.to(ProductListSneakers());
                        },
                        child: Text('sneakers'),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      // === 2번 아이콘 ===
                      GestureDetector(
                        onTap: () {
                          Get.to(ProductListBoots());
                        },
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/icon1.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(ProductListBoots());
                        },
                        child: Text('boots'),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      // === 3번 아이콘 ===
                      GestureDetector(
                        onTap: () {
                          Get.to(ProductListSlip());
                        },
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: ClipOval(
                            child: Image.asset(
                              'assets/images/icon1.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(ProductListSlip());
                        },
                        child: Text('slip'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
