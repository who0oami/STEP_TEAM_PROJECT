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
  late CustomerHandler handler;
  Customer? _customer;
  File? profileImage;

  @override
  void initState() {
    super.initState();
    handler =
        CustomerHandler(); // DB 연결 객체 (handler 내부에서 DB 열도록 구현되어 있다고 가정)
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
    Customer? data = await handler.getCustomer(widget.customerId!);
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
            Row(
              children: [
                CircleAvatar(
                  radius: 45,
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
              ],
            ),

            const SizedBox(height: 30),

            // ----------------------------------------
            // 프로필 정보 텍스트 영역
            // ----------------------------------------
            buildInfoRow("프로필 이름", _customer!.customer_name),
            buildInfoRow("이름", _customer!.customer_name),
            buildInfoRow("이메일", _customer!.customer_email),

            const SizedBox(height: 40),

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
  Widget buildInfoRow(String title, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 제목
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          // 값
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
