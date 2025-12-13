import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _edited = widget.customer;

    final path = _edited.customer_image;
    _profileImageFile = (path != null && path.isNotEmpty)
        ? File(path)
        : null;
  }

  Future<void> _pickProfileImage() async {
    final XFile? picked = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (picked == null) return;

    setState(() {
      _profileImageFile = File(picked.path);

      _edited = Customer(
        customer_id: _edited.customer_id,
        customer_name: _edited.customer_name,
        customer_phone: _edited.customer_phone,
        customer_pw: _edited.customer_pw,
        customer_email: _edited.customer_email,
        customer_address: _edited.customer_address,
        customer_image: picked.path, // ✅ 선택한 이미지 경로 저장
      );
    });
  }

  Future<void> _showChangeProfileNameDialog() async {
    final controller = TextEditingController(
      text: _edited.customer_name,
    );

    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('프로필 이름 변경'),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: '새 프로필 이름 입력',
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

    if (result == null || result.isEmpty) return;

    setState(() {
      _edited = Customer(
        customer_id: _edited.customer_id,
        customer_name: result, // ✅ 프로필 이름 변경
        customer_phone: _edited.customer_phone,
        customer_pw: _edited.customer_pw,
        customer_email: _edited.customer_email,
        customer_address: _edited.customer_address,
        customer_image: _edited.customer_image,
      );
    });
  }

  // ✅ 저장 버튼 누르면만 저장(결과 반환)
  void _saveAndClose() {
    Navigator.pop(context, _edited);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('프로필 관리'),
        centerTitle: false,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context), // ✅ 저장 없이 뒤로가기
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ 프로필 이미지 + 편집 버튼(오버레이)
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 48,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: _profileImageFile != null
                        ? FileImage(_profileImageFile!)
                        : null,
                    child: _profileImageFile == null
                        ? const Icon(
                            Icons.person,
                            size: 48,
                            color: Colors.grey,
                          )
                        : null,
                  ),
                  Positioned(
                    bottom: 6,
                    child: InkWell(
                      onTap: _pickProfileImage,
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.35),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Text(
                          '편집',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            const Text(
              '프로필 정보',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 14),

            // ✅ 프로필 이름 (변경 버튼 있음)
            _twoLineRow(
              title: '프로필 이름',
              value: _edited.customer_name,
              showChangeButton: true,
              onChange: _showChangeProfileNameDialog,
            ),
            const Divider(height: 24),

            // ✅ 이름 (버튼 없음)
            _twoLineRow(
              title: '이름',
              value: 'User Name',
              showChangeButton: false,
            ),
            const Divider(height: 24),

            // ✅ 이메일 (버튼 없음)
            _twoLineRow(
              title: '이메일',
              value: _edited.customer_email,
              showChangeButton: false,
            ),
            const Divider(height: 24),

            const Spacer(),

            // ✅ 저장 버튼(하단)
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
    );
  }

  Widget _twoLineRow({
    required String title,
    required String value,
    required bool showChangeButton,
    VoidCallback? onChange,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (showChangeButton)
          SizedBox(
            width: 60,
            height: 34,
            child: OutlinedButton(
              onPressed: onChange,
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('변경', style: TextStyle(fontSize: 12)),
            ),
          ),
      ],
    );
  }
}
