import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:step_app/model/customer.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({super.key, required this.customer});

  final Customer customer;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late Customer _edited;
  File? _profileImageFile;

  final ImagePicker _picker = ImagePicker();

  // image picker 두 번 연속 실행 방지(already_active 방지)
  bool _isPickingImage = false;

  @override
  void initState() {
    super.initState();
    _edited = widget.customer;

    final path = _edited.customer_image;
    _profileImageFile = (path != null && path.isNotEmpty)
        ? File(path)
        : null;
  }

  // Customer에서 필요한 값만 바꿔서 새로 만들기
  Customer _copyCustomer({
    String? customerName,
    String? customerImage,
  }) {
    return Customer(
      customer_id: _edited.customer_id,
      customer_name: customerName ?? _edited.customer_name,
      customer_phone: _edited.customer_phone,
      customer_pw: _edited.customer_pw,
      customer_email: _edited.customer_email,
      customer_address: _edited.customer_address,
      customer_image: customerImage ?? _edited.customer_image,
      customer_lat: _edited.customer_lat,
      customer_lng: _edited.customer_lng,
    );
  }

  Future<void> _pickProfileImage() async {
    if (_isPickingImage) return;
    _isPickingImage = true;

    try {
      final XFile? picked = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );
      if (picked == null) return;

      setState(() {
        _profileImageFile = File(picked.path);
        _edited = _copyCustomer(customerImage: picked.path);
      });
    } finally {
      _isPickingImage = false;
    }
  }

  Future<void> _showChangeProfileNameDialog() async {
    final controller = TextEditingController(
      text: _edited.customer_name,
    );

    final result = await Get.dialog<String>(
      AlertDialog(
        title: Text('프로필 이름 변경'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(hintText: '새 프로필 이름 입력'),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: null),
            child: Text('취소'),
          ),
          ElevatedButton(
            onPressed: () => Get.back(result: controller.text.trim()),
            child: Text('확인'),
          ),
        ],
      ),
      barrierDismissible: true,
    );

    if (result == null || result.isEmpty) return;

    setState(() {
      _edited = _copyCustomer(customerName: result);
    });
  }

  void _saveAndClose() {
    // 내일 DB 붙일 때 여기서 updateCustomer(_edited) 넣으면 됨
    Get.back(result: _edited);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('프로필 관리'),
        centerTitle: false,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(), // 저장 안 하고 뒤로가기
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                        ? Icon(
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
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0x59000000),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
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
            SizedBox(height: 28),

            Text(
              '프로필 정보',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 14),

            _twoLineRow(
              title: '프로필 이름',
              value: _edited.customer_name,
              showChangeButton: true,
              onChange: _showChangeProfileNameDialog,
            ),
            Divider(height: 24),

            _twoLineRow(
              title: '이름',
              value: 'User Name',
              showChangeButton: false,
            ),
            Divider(height: 24),

            _twoLineRow(
              title: '이메일',
              value: _edited.customer_email,
              showChangeButton: false,
            ),
            Divider(height: 24),

            Spacer(),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _saveAndClose,
                child: Text('저장'),
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
            padding: EdgeInsets.symmetric(vertical: 6),
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
                SizedBox(height: 6),
                Text(
                  value,
                  style: TextStyle(
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
              child: Text('변경', style: TextStyle(fontSize: 12)),
            ),
          ),
      ],
    );
  }
}
