import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeTabSecondPage extends StatefulWidget {
  const HomeTabSecondPage({super.key});

  @override
  State<HomeTabSecondPage> createState() =>
      _HomeTabSecondPageState();
}

class _HomeTabSecondPageState
    extends State<HomeTabSecondPage> {
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

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    // === 1번 아이콘 ===
                    GestureDetector(
                      onTap: () {
                        //   Get.to(    );
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
                        //
                      },
                      child: Text('category 1'),
                    ),
                  ],
                ),
                Column(
                  children: [
                    // === 2번 아이콘 ===
                    GestureDetector(
                      onTap: () {
                        //   Get.to(    );
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
                        //
                      },
                      child: Text('category 2'),
                    ),
                  ],
                ),
                Column(
                  children: [
                    // === 3번 아이콘 ===
                    GestureDetector(
                      onTap: () {
                        //   Get.to(    );
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
                        //
                      },
                      child: Text('category 3'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
