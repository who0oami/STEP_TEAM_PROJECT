import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart' as latlng;
import 'package:step_app/model/branch.dart';
import 'package:step_app/util/scolor.dart';
import 'package:step_app/vm/database_handler_branch.dart';

/* 
Description : 결제 페이지에서 전달된 매장명 기반 지도 조회
  - 1) 결제 페이지에서 전달된 매장명 있으면 TextField에 채움
  - 2) 검색 아이콘 클릭 시
        입력 값 없으면 전체 매장 조회
        입력 값 있으면 해당 매장명 검색
  - 3) 매장 선택 후 '확정하기' 클릭 시
        선택한 매장 정보(이름, 주소, 위도, 경도, 전화번호) 결제 페이지로 반환
Date : 2025-12-14
Author : 지현
*/

class StoreFinderPage extends StatefulWidget {
  const StoreFinderPage({super.key});

  @override
  State<StoreFinderPage> createState() => _StoreFinderPageState();
}

class _StoreFinderPageState extends State<StoreFinderPage> {
  late TextEditingController branchName; // 대리점명
  late List<Branch> branchList = []; // 매장 정보
  Branch? selectedBranch; // 선택한 대리점
  final BranchHandler handler = BranchHandler(); // DB 핸들러

  // 지도
  late MapController mapController; // 지도 컨트롤러
  double? latData; // 위도
  double? longData; // 경도
  bool canShowMap = false; // 지도 표시 여부

  @override
  void initState() {
    super.initState();
    mapController = MapController();

    // 결제 페이지에서 전달된 매장명 있으면 TextField에 채움
    final args = Get.arguments;
    branchName = TextEditingController(
      text: args != null && args['branchName'] != null
          ? args['branchName']
          : '',
    );
  }

  @override
  void dispose() {
    branchName.dispose();
    super.dispose();
  }

  // 검색 버튼
  Future<void> searchBranches() async {
    final query = branchName.text.trim();
    final allBranches = await handler.queryBranch();

    setState(() {
      if (query.isEmpty) {
        branchList = allBranches; // 전체 조회
      } else {
        branchList =
            allBranches.where((b) => b.branch_name.contains(query)).toList();
      }
      selectedBranch = null;
      canShowMap = false;
    });
  }

  // 매장 선택
  void selectBranch(Branch branch) {
    setState(() {
      selectedBranch = branch;
      latData = branch.branch_lat;
      longData = branch.branch_lng;
      canShowMap = true;

      // 지도 이동
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (latData != null && longData != null) {
          mapController.move(latlng.LatLng(latData!, longData!), 17.0);
        }
      });
    });
  }

  // 지도 위젯
  Widget buildMap() {
    if (!canShowMap || latData == null || longData == null) {
      return const Center(
        child: Text(
          '지도 영역',
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: latlng.LatLng(latData!, longData!),
        initialZoom: 17.0,
      ),
      children: [
        TileLayer(
          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          userAgentPackageName: 'com.tj.gpsmapapp',
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: latlng.LatLng(latData!, longData!),
              width: 80,
              height: 80,
              child: const Icon(Icons.pin_drop, size: 50, color: Colors.red),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PColor.baseBackgroundColor,
      appBar: AppBar(
        backgroundColor: PColor.appBarBackgroundColor,
        title: const Text(
          '매장 조회',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: branchName,
                    decoration: InputDecoration(
                      hintText: '매장명을 입력하세요 (예: 강남)',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: IconButton(
                        onPressed: searchBranches,
                        icon: const Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: branchList.isEmpty
                  ? const Center(child: Text('검색 버튼을 눌러 매장을 조회하세요.'))
                  : ListView.builder(
                      itemCount: branchList.length,
                      itemBuilder: (context, index) {
                        final branch = branchList[index];
                        return ListTile(
                          leading: Radio<Branch>(
                            value: branch,
                            groupValue: selectedBranch,
                            onChanged: (_) => selectBranch(branch),
                          ),
                          title: Text(branch.branch_name),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('매장 주소: ${branch.branch_location}'),
                              Text('매장 전화번호: ${branch.branch_phone}'),
                            ],
                          ),
                        );
                      },
                    ),
            ),
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(16),
              ),
              child: buildMap(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: selectedBranch == null
                ? null
                : () {
                    Get.back(
                      result: {
                        'branchName': selectedBranch!.branch_name,
                      },
                    );
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              '확정하기',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
