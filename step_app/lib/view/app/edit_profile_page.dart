import 'dart:io';

import 'package:flutter/material.dart';
import 'package:step_app/model/customer.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key, required this.customer});

  final Customer customer;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late Customer _edited;
  File? _profileImageFile;

  @override
  void initState() {
    super.initState();
    _edited = widget.customer;

    final path = _edited.customer_image;
    _profileImageFile = (path != null && path.isNotEmpty)
        ? File(path)
        : null;
  }

  void _setName(String newName) {
    setState(() {
      _edited = Customer(
        customer_id: _edited.customer_id,
        customer_name: newName,
        customer_phone: _edited.customer_phone,
        customer_pw: _edited.customer_pw,
        customer_email: _edited.customer_email,
        customer_address: _edited.customer_address,
        customer_image: _edited.customer_image,
      );
    });
  }

  Future<void> _showChangeNameDialog() async {
    final controller = TextEditingController(
      text: _edited.customer_name,
    );

    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('이름 변경'),
          content: SingleChildScrollView(
            child: TextField(
              controller: controller,
              autofocus: false, //  다이얼로그 뜰 때 키보드 자동으로 안 올라옴
              decoration: const InputDecoration(hintText: '새 이름 입력'),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, null),
              child: const Text('취소'),
            ),
            ElevatedButton(
              onPressed: () =>
                  Navigator.pop(context, controller.text.trim()),
              child: const Text('확인'),
            ),
          ],
        );
      },
    );

    if (result != null && result.isNotEmpty) {
      _setName(result);
    }
  }

  void _saveAndClose() {
    //  ProfileViewPage로 수정된 customer 반환
    Navigator.pop(context, _edited);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // 키보드 올라올 때 레이아웃 밀기
      appBar: AppBar(title: const Text('프로필 편집'), centerTitle: true),
      body: GestureDetector(
        onTap: () =>
            FocusScope.of(context).unfocus(), // 빈 곳 누르면 키보드 내리기
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =========================
              // 프로필 이미지
              // =========================
              Row(
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: _profileImageFile != null
                        ? FileImage(_profileImageFile!)
                        : null,
                    child: _profileImageFile == null
                        ? const Icon(
                            Icons.person,
                            size: 45,
                            color: Colors.grey,
                          )
                        : null,
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _edited.customer_name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(_edited.customer_email),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // =========================
              // 이름 변경 버튼 (AlertDialog)
              // =========================
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: _showChangeNameDialog,
                  child: const Text('프로필이름 변경'),
                ),
              ),

              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),

              // =========================
              // (표시용) 기타 정보
              // =========================
              _infoLine('전화번호', _edited.customer_phone),
              const SizedBox(height: 10),
              _infoLine('이메일', _edited.customer_email),
              const SizedBox(height: 10),
              _infoLine('주소', _edited.customer_address),

              const Spacer(),

              // =========================
              // 저장 버튼
              // =========================
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _saveAndClose,
                  child: const Text('저장'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoLine(String title, String value) {
    return Row(
      children: [
        SizedBox(
          width: 70,
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        Expanded(child: Text(value)),
      ],
    );
  }
}
