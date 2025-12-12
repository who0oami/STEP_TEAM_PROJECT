import 'dart:io';
import 'package:flutter/material.dart';
import 'package:step_app/model/customer.dart';
import 'package:step_app/vm/database_handler_customer.dart';
import 'edit_profile_page.dart';

class ProfileViewPage extends StatefulWidget {
  final int? customerId; // ← 로그인 후 전달될 값 (지금은 없어도 실행 가능)

  const ProfileViewPage({super.key, this.customerId});

  @override
  State<ProfileViewPage> createState() => _ProfileViewPageState();
}

class _ProfileViewPageState extends State<ProfileViewPage> {
  late DatabaseHandlerCustomer handler; // ✅ 클래스명 수정
  Customer? _customer;
  File? profileImage;

  @override
  void initState() {
    super.initState();
    handler = DatabaseHandlerCustomer(); // ✅ 올바른 클래스 사용
    loadCustomer();
  }

  // ------------------------------
  // 고객 데이터 로드 (DB or Dummy)
  // ------------------------------
  Future<void> loadCustomer() async {
    if (widget.customerId == null) {
      // 🎨 화면 디자인 테스트용 더미 데이터
      _customer = Customer(
        customer_id: 0,
        customer_name: "홍길동",
        customer_phone: "010-1234-5678",
        customer_pw: "1234",
        customer_email: "test@example.com",
        customer_address: "서울 강남구",
        customer_image: null,
      );
      profileImage = null;
      setState(() {});
      return;
    }

    // 로그인 연동 후 사용할 DB 조회
    Customer? data = await handler.getCustomerById(
      widget.customerId!,
    ); // ✅ 메서드명 수정
    if (data != null) {
      setState(() {
        _customer = data;
        profileImage =
            (data.customer_image != null &&
                data.customer_image!.isNotEmpty)
            ? File(data.customer_image!)
            : null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_customer == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("프로필"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ----------------------------------------
            // 프로필 이미지 + 왼쪽 위에 배치
            // ----------------------------------------
            Column(
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
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildInfoRow(_customer!.customer_name),
                        buildInfoRow(
                          _customer!.customer_phone,
                        ), // ✅ 중복된 name → phone
                        buildInfoRow(_customer!.customer_email),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 40),

            // ----------------------------------------
            // 프로필 편집 버튼
            // ----------------------------------------
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  // Edit 페이지로 이동하고, 수정된 Customer 객체를 반환받음
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          EditProfilePage(customer: _customer!),
                    ),
                  );

                  // 반환값이 있으면 즉시 반영 (이름 / 이미지)
                  if (result != null && result is Customer) {
                    setState(() {
                      _customer = result;
                      profileImage =
                          (result.customer_image != null &&
                              result.customer_image!.isNotEmpty)
                          ? File(result.customer_image!)
                          : null;
                    });
                  } else {
                    // 만약 Edit 페이지에서 DB에만 업데이트 했다면, 안전하게 DB에서 다시 불러오기
                    await loadCustomer();
                  }
                },
                child: const Text("프로필 편집"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------------
  // 표시용 Row
  // ------------------------------
  Widget buildInfoRow(String value) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Text(
        value,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }
}
