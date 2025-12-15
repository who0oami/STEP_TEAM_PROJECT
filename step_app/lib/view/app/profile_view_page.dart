import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:step_app/model/customer.dart';
import 'package:step_app/util/message.dart';
import 'package:step_app/util/scolor.dart';
import 'package:step_app/view/app/edit_profile_page.dart';
import 'package:step_app/view/app/order_history_page.dart';
import 'package:step_app/model/purchase_list_item.dart';

class ProfileViewPage extends StatefulWidget {
  final int? customerId;
  ProfileViewPage({super.key, this.customerId});

  @override
  State<ProfileViewPage> createState() => _ProfileViewPageState();
}

class _ProfileViewPageState extends State<ProfileViewPage> {
  final Message _msg = Message();

  File? profileImage;
  String name = '홍길동';
  String profileName = 'taxol';
  String email = 'test@example.com';

  Customer? customer;

  @override
  void initState() {
    super.initState();

    // 지금은 더미. 내일 DB 붙이면 여기만 바꿔도 됨
    customer = Customer(
      customer_id: widget.customerId ?? 1,
      customer_name: profileName,
      customer_phone: '010-1234-5678',
      customer_pw: '1234',
      customer_email: email,
      customer_address: '서울 강남구 테헤란로 123',
      customer_image: null,
      customer_lat: null,
      customer_lng: null,
    );

    _applyCustomerToView(customer!);
  }

  void _applyCustomerToView(Customer c) {
    profileName = c.customer_name;
    email = c.customer_email;

    final path = c.customer_image;
    profileImage = (path != null && path.isNotEmpty)
        ? File(path)
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PColor.baseBackgroundColor,
      appBar: AppBar(
        title: Text("마이 페이지"),
        centerTitle: true,
        backgroundColor: PColor.appBarBackgroundColor,
        foregroundColor: PColor.appBarForegroundColor,
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: profileImage != null
                        ? FileImage(profileImage!)
                        : null,
                    child: profileImage == null
                        ? Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.grey,
                          )
                        : null,
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _infoText(name),
                      _infoText(profileName),
                      _infoText(email),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 44,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PColor.buttonPrimary,
                    foregroundColor: PColor.appBarForegroundColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  onPressed: () async {
                    if (customer == null) {
                      _msg.snackBar('알림', '고객 정보가 없습니다.');
                      return;
                    }

                    final result = await Get.to<Customer>(
                      () => EditProfilePage(customer: customer!),
                    );

                    if (result != null) {
                      setState(() {
                        customer = result;
                        _applyCustomerToView(result);
                      });
                      _msg.snackBar('완료', '프로필이 저장되었습니다.');
                    }
                  },
                  child: Text(
                    "프로필 편집",
                    style: TextStyle(color: PColor.buttonTextColor),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Expanded(child: PurchaseListSection()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoText(String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Text(
        value,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class PurchaseListSection extends StatefulWidget {
  PurchaseListSection({super.key});

  @override
  State<PurchaseListSection> createState() =>
      _PurchaseListSectionState();
}

class _PurchaseListSectionState extends State<PurchaseListSection> {
  final Message _msg = Message();

  final TextEditingController _searchController =
      TextEditingController();
  String _query = '';

  late List<PurchaseListItem> _items;

  @override
  void initState() {
    super.initState();

    // 더미. images 폴더의 이미지 2개 사용
    _items = <PurchaseListItem>[
      PurchaseListItem(
        orderId: 1,
        imageBytes: Uint8List(0),
        imageAssetPath: 'images/nike01.png', // ✅ 추가
        productName: '에어줌 페가수스',
        brandName: 'NIKE',
        branchName: '강남구 지점',
        sizeText: '270',
        pickupStatus: 0,
      ),
      PurchaseListItem(
        orderId: 2,
        imageBytes: Uint8List(0),
        imageAssetPath: 'images/new01.png', // ✅ 추가
        productName: '슈퍼스타',
        brandName: 'ADIDAS',
        branchName: '서초구 지점',
        sizeText: '265',
        pickupStatus: 1,
      ),
    ];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final q = _query.trim().toLowerCase();
    final filtered = q.isEmpty
        ? _items
        : _items
              .where((e) => e.productName.toLowerCase().contains(q))
              .toList();

    return Column(
      children: [
        Row(
          children: [
            Text(
              '구매 내역',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            Spacer(),
            SizedBox(
              width: 260,
              height: 38,
              child: TextField(
                controller: _searchController,
                onChanged: (v) => setState(() => _query = v),
                decoration: InputDecoration(
                  hintText: '제품명 검색',
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  prefixIcon: Icon(Icons.search, size: 18),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Expanded(
          child: filtered.isEmpty
              ? Center(child: Text('검색 결과가 없습니다.'))
              : ListView.separated(
                  itemCount: filtered.length,
                  separatorBuilder: (_, __) => SizedBox(height: 12),
                  itemBuilder: (context, index) =>
                      _buildPurchaseCard(filtered[index]),
                ),
        ),
      ],
    );
  }

  Widget _buildPurchaseCard(PurchaseListItem item) {
    final bool isWaiting = item.pickupStatus == 0;

    return InkWell(
      onTap: () async {
        final bool confirmed =
            (await Get.to<bool>(
              () => OrderHistoryPage(item: item),
            )) ??
            false;

        if (confirmed) {
          setState(() => item.pickupStatus = 1);
          _msg.snackBar('완료', '픽업 완료 처리되었습니다.');
        }
      },
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Color(0xFFF6F6F6),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: item.imageBytes.isNotEmpty
                  ? Image.memory(
                      item.imageBytes,
                      width: 72,
                      height: 72,
                      fit: BoxFit.cover,
                    )
                  : (item.imageAssetPath != null &&
                        item.imageAssetPath!.isNotEmpty)
                  ? Image.asset(
                      item.imageAssetPath!,
                      width: 72,
                      height: 72,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      width: 72,
                      height: 72,
                      alignment: Alignment.center,
                      color: Color(0xFFEAEAEA),
                      child: Icon(Icons.image_not_supported),
                    ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.productName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    '브랜드: ${item.brandName}',
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '대리점: ${item.branchName}',
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'SIZE: ${item.sizeText}',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),
            Text(
              isWaiting ? '픽업대기중' : '픽업완료',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: isWaiting
                    ? PColor.buttonGray
                    : PColor.appBarForegroundColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
