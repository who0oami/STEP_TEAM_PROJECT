import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_app/model/product.dart';
import 'package:step_app/view/app/login_page.dart';
import 'package:step_app/view/app/product_page/home_tab_first_page.dart';
import 'package:step_app/view/app/product_page/home_tab_second_page.dart';
import 'package:step_app/view/app/product_page/home_tab_third_page.dart';
import 'package:step_app/vm/database_handler_product.dart';
import 'package:step_app/vm/seeds/seed_branch.dart';
import 'package:step_app/vm/seeds/seed_category_color.dart';
import 'package:step_app/vm/seeds/seed_category_manufacturer.dart';
import 'package:step_app/vm/seeds/seed_category_size.dart';
import 'package:step_app/vm/seeds/seed_customer.dart';
import 'package:step_app/vm/seeds/seed_emplyee.dart';
import 'package:step_app/vm/seeds/seed_manufacturer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  // property
  late TabController tabController;
  late TextEditingController searchController;
  late List<Product> allProducts; // 전체 데이터
  late List<Product> filteredProducts; // 검색 결과

  @override
  void initState() {
    // 탭 컨트롤러 초기화 (탭 3개)
    tabController = TabController(length: 3, vsync: this);
    searchController = TextEditingController();

    allProducts = []; // DB or seed에서 불러온 전체 목록
    filteredProducts = [];

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
    SeedManufacturer.insertSeed();
    SeedEmployee.insertSeed();
    SeedCustomer.insertSeed();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
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
                      onChanged: filterProducts,
                      decoration: InputDecoration(
                        labelText: 'Search',
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            searchController.clear();
                            filterProducts('');
                          },
                        ),

                        border: UnderlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 10,
                        ),
                      ),
                      onSubmitted: (value) {
                        //
                      },
                    ),
                  ),

                  SizedBox(width: 12),

                  // 아이콘 (로그인)
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
              color: Color.fromARGB(255, 255, 255, 255),
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
                  HomeTabThirdPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  } // build

  void filterProducts(String keyword) {
    if (keyword.isEmpty) {
      setState(() {
        filteredProducts = allProducts;
      });
      return;
    }

    // setState(() {
    //   filteredProducts = allProducts.where((product) {
    //     return product.name.contains(keyword) ||
    //         product.manufacturer.contains(keyword);
    //   }).toList();
    // });
  }
} // class
