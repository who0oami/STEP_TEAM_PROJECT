import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_app/util/scolor.dart';
import 'package:step_app/view/app/product_page/product_list_newbalance.dart';
import 'package:step_app/view/app/product_page/product_list_nike.dart';

class HomeTabFirstPage extends StatefulWidget {
  const HomeTabFirstPage({super.key});

  @override
  State<HomeTabFirstPage> createState() =>
      _HomeTabFirstPageState();
}

class _HomeTabFirstPageState
    extends State<HomeTabFirstPage> {
  // property
  int _currentIndex = 0;
  final List<String> bannerImages = [
    'images/AIR+FORCE+3.png',
    'images/AIR+FORCE+7.png',
    'images/model.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
        child: Column(
          children: [
            // 이미지 캐러셀(s)
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                // 🔹 Carousel
                CarouselSlider(
                  options: CarouselOptions(
                    height: 350.0,
                    autoPlay: true,
                    viewportFraction: 0.9,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                  items: bannerImages.map((imagePath) {
                    return Container(
                      width:
                          MediaQuery.of(
                            context,
                          ).size.width -
                          32,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage(imagePath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }).toList(),
                ),

                // 🔹 고정된 indicator (움직이지 않음)
                Positioned(
                  bottom: 12,
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: List.generate(
                      bannerImages.length,
                      (index) {
                        return AnimatedContainer(
                          duration: const Duration(
                            milliseconds: 300,
                          ),
                          margin:
                              const EdgeInsets.symmetric(
                                horizontal: 3,
                              ),
                          width: _currentIndex == index
                              ? 10
                              : 8,
                          height: _currentIndex == index
                              ? 10
                              : 8,
                          decoration: BoxDecoration(
                            color: _currentIndex == index
                                ? Colors.black
                                : PColor.buttonGray,
                            shape: BoxShape.circle,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),

            // 이미지 캐러셀(e)
            SizedBox(height: 30),
            SizedBox(
              height: 150,
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      // === 1번 아이콘 ===
                      GestureDetector(
                        onTap: () {
                          Get.to(ProductListNike());
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          padding: EdgeInsets.all(
                            3,
                          ), // 테두리 두께
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: PColor.buttonGray,
                              width: 3,
                            ),
                          ),

                          child: ClipOval(
                            child: Image.asset(
                              'images/AIR+FORCE+4.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(ProductListNike());
                        },
                        child: Text(
                          'NIKE',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  // === 2번 아이콘 ===
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(ProductListNewbalance());
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          padding: EdgeInsets.all(
                            3,
                          ), // 테두리 두께
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: PColor.buttonGray,
                              width: 3,
                            ),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              'images/AIR+FORCE+1.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(ProductListNewbalance());
                        },
                        child: Text(
                          'NEW BALANCE',
                          style: TextStyle(fontSize: 18),
                        ),
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
