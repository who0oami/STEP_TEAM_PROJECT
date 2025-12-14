import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_app/view/app/login_page.dart';
import 'package:step_app/view/app/product_page/home_tab_first_page.dart';
import 'package:step_app/view/app/product_page/home_tab_second_page.dart';
import 'package:step_app/view/app/product_page/home_tab_third_page.dart';
import 'package:step_app/vm/seeds/seed_branch.dart';
import 'package:step_app/vm/seeds/seed_category_color.dart';
import 'package:step_app/vm/seeds/seed_category_manufacturer.dart';
import 'package:step_app/vm/seeds/seed_category_product.dart';
import 'package:step_app/vm/seeds/seed_category_size.dart';
import 'package:step_app/vm/seeds/seed_customer.dart';
import 'package:step_app/vm/seeds/seed_emplyee.dart';
import 'package:step_app/vm/seeds/seed_manufacturer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>
    with SingleTickerProviderStateMixin {
  // property
  late TabController tabController;
  late TextEditingController searchController;

  @override
  void initState() {
    // 탭 컨트롤러 초기화 (탭 3개)
    tabController = TabController(length: 3, vsync: this);
    searchController = TextEditingController();
    super.initState();
  }

  // 초기값
  @override
  void dispose() {
    tabController.dispose();
    searchController.dispose();
    // 초기값 사용 후 삭제 必
    SeedBranch.insertSeed();
    SeedCategorySize.insertSeed();
    SeedCategoryColor.insertSeed();
    SeedCategoryManufacturer.insertSeed();
    SeedProduct.insertSeed();
    SeedManufacturer.insertSeed();
    SeedEmployee.insertSeed();
    SeedProduct.insertSeed();
    SeedCustomer.insertSeed();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 8.0,
                bottom: 8.0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        labelText: 'Search',
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            searchController.clear();
                          },
                        ),

                        border: UnderlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 10,
                            ),
                      ),
                      onSubmitted: (value) {
                        //
                      },
                    ),
                  ),

                  const SizedBox(width: 8),

                  // 첫 번째 아이콘
                  // IconButton(
                  //   onPressed: () {
                  //     // Get.to(loginPage());
                  //   },
                  //   icon: Icon(
                  //     Icons.shopping_bag_outlined,
                  //     size: 28,
                  //   ),
                  // ),
                  // const SizedBox(width: 4),
                  // 두 번째 아이콘 (로그인)
                  IconButton(
                    onPressed: () {
                      Get.to(LoginPage());
                    },
                    icon: Icon(Icons.person, size: 28),
                  ),
                ],
              ),
            ),

            //  TabBar
            Container(
              height: 50,
              color: const Color.fromARGB(
                255,
                255,
                227,
                145,
              ),
              child: TabBar(
                controller: tabController,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.black,
                indicatorColor: Colors.black,
                indicatorWeight: 3,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  Tab(text: 'TODAY`S'),
                  Tab(text: 'MEN'),
                  Tab(text: 'WOMAN'),
                ],
              ),
            ),

            // TabBarView
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  HomeTabFirstPage(),
                  HomeTabSecondPage(),
                  HomeTabThirdPage(), // PrdTabThirdPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
