import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:step_app/model/customer.dart';
import 'package:step_app/util/message.dart';
import 'package:step_app/util/scolor.dart';
import 'package:step_app/view/app/edit_profile_page.dart';
import 'package:step_app/view/app/order_history_page.dart'; // PurchaseListItem 타입

class ProfileViewPage extends StatefulWidget {
  final int? customerId;
  const ProfileViewPage({super.key, this.customerId});

  @override
  State<ProfileViewPage> createState() => _ProfileViewPageState();
}

class _ProfileViewPageState extends State<ProfileViewPage> {
  final Message _msg = Message();

  // ✅ 더미 프로필 (편집 후 setState로 바뀌게 final 제거)
  File? profileImage;
  String name = '홍길동';
  String profileName = 'taxol';
  String email = 'test@example.com';

  // ✅ EditProfilePage에 넘길 Customer 상태
  Customer? customer;

  @override
  void initState() {
    super.initState();
    customer = Customer(
      customer_id: widget.customerId ?? 1,
      customer_name: profileName, // Edit 페이지에서 '프로필이름 변경'으로 바뀌는 값
      customer_phone: '010-1234-5678',
      customer_pw: '1234',
      customer_email: email,
      customer_address: '서울 강남구 테헤란로 123',
      customer_image: null, // 이미지 파일 경로 없으면 null
    );

    // (선택) 화면에 보여주는 변수들도 customer랑 동기화
    profileName = customer!.customer_name;
    email = customer!.customer_email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PColor.baseBackgroundColor,
      appBar: AppBar(
        title: const Text("프로필"),
        centerTitle: true,
        backgroundColor: PColor.appBarBackgroundColor,
        foregroundColor: PColor.appBarForegroundColor,
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
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
                        ? const Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.grey,
                          )
                        : null,
                  ),
                  const SizedBox(width: 12),
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
              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                height: 44,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PColor.buttonGray,
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

                    // ✅ 편집 페이지로 이동 + 수정된 Customer 받기
                    final result = await Get.to<Customer>(
                      () => EditProfilePage(customer: customer!),
                    );

                    if (result != null) {
                      setState(() {
                        customer = result;

                        // ✅ 화면 표시값 갱신
                        profileName = result.customer_name;
                        email = result.customer_email;

                        final path = result.customer_image;
                        profileImage =
                            (path != null && path.isNotEmpty)
                            ? File(path)
                            : null;
                      });
                      _msg.snackBar('완료', '프로필이 저장되었습니다.');
                    }
                  },
                  child: const Text("프로필 편집"),
                ),
              ),

              const SizedBox(height: 16),

              const Expanded(child: PurchaseListSection()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoText(String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        value,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class PurchaseListSection extends StatefulWidget {
  const PurchaseListSection({super.key});

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
    _items = <PurchaseListItem>[
      PurchaseListItem(
        orderId: 1,
        imageBytes: Uint8List(0),
        productName: '에어줌 페가수스',
        brandName: 'NIKE',
        branchName: '강남구 대리점',
        sizeText: '270',
        pickupStatus: 0,
      ),
      PurchaseListItem(
        orderId: 2,
        imageBytes: Uint8List(0),
        productName: '슈퍼스타',
        brandName: 'ADIDAS',
        branchName: '서초구 대리점',
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
            const Text(
              '구매 내역',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: 260,
              height: 38,
              child: TextField(
                controller: _searchController,
                onChanged: (v) => setState(() => _query = v),
                decoration: InputDecoration(
                  hintText: '제품명 검색',
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  prefixIcon: const Icon(Icons.search, size: 18),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Expanded(
          child: filtered.isEmpty
              ? const Center(child: Text('검색 결과가 없습니다.'))
              : ListView.separated(
                  itemCount: filtered.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: 12),
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
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: const Color(0xFFF6F6F6),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: item.imageBytes.isEmpty
                  ? Container(
                      width: 72,
                      height: 72,
                      alignment: Alignment.center,
                      color: const Color(0xFFEAEAEA),
                      child: const Icon(Icons.image_not_supported),
                    )
                  : Image.memory(
                      item.imageBytes,
                      width: 72,
                      height: 72,
                      fit: BoxFit.cover,
                    ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.productName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '브랜드: ${item.brandName}',
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '대리점: ${item.branchName}',
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'SIZE: ${item.sizeText}',
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
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
