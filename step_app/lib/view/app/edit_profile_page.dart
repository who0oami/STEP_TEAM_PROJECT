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
<<<<<<< HEAD
  late Customer _edited;
  File? _profileImageFile;
=======
  File? _profileImage;
  late TextEditingController profileNameController;

  bool _isPicking = false;
  late DatabaseHandlerCustomer handler; // ✅ 클래스명 수정
>>>>>>> main

  @override
  void initState() {
    super.initState();
<<<<<<< HEAD
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
=======
    handler = DatabaseHandlerCustomer(); // ✅ 인스턴스 생성 수정
    profileNameController = TextEditingController(
      text: widget.customer.customer_name,
    );
  }

  @override
  void dispose() {
    profileNameController.dispose(); // ✅ 메모리 관리
    super.dispose();
  }

  Future<void> pickImage() async {
    if (_isPicking) return;
    _isPicking = true;

    try {
      final picker = ImagePicker();
      final result = await picker.pickImage(
        source: ImageSource.gallery,
>>>>>>> main
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

<<<<<<< HEAD
  void _saveAndClose() {
    //  ProfileViewPage로 수정된 customer 반환
    Navigator.pop(context, _edited);
=======
  Future<void> _saveProfile() async {
    Customer updated = Customer(
      customer_id: widget.customer.customer_id,
      customer_name: profileNameController.text.trim(),
      customer_phone: widget.customer.customer_phone,
      customer_pw: widget.customer.customer_pw,
      customer_email: widget.customer.customer_email,
      customer_address: widget.customer.customer_address,
      customer_image:
          _profileImage?.path ?? widget.customer.customer_image,
    );

    await handler.updateCustomer(updated); // ✅ DB 핸들러 메서드 사용
    if (mounted) Navigator.pop(context, updated);
>>>>>>> main
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
      resizeToAvoidBottomInset: true, // 키보드 올라올 때 레이아웃 밀기
      appBar: AppBar(title: const Text('프로필 편집'), centerTitle: true),
      body: GestureDetector(
        onTap: () =>
            FocusScope.of(context).unfocus(), // 빈 곳 누르면 키보드 내리기
=======
      appBar: AppBar(
        title: const Text("프로필 관리"),
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
>>>>>>> main
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
<<<<<<< HEAD
                    backgroundImage: _profileImageFile != null
                        ? FileImage(_profileImageFile!)
                        : null,
                    child: _profileImageFile == null
=======
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!)
                        : (widget.customer.customer_image != null &&
                                  widget
                                      .customer
                                      .customer_image!
                                      .isNotEmpty
                              ? FileImage(
                                  File(
                                    widget.customer.customer_image!,
                                  ),
                                )
                              : null),
                    child:
                        _profileImage == null &&
                            (widget.customer.customer_image == null ||
                                widget
                                    .customer
                                    .customer_image!
                                    .isEmpty)
>>>>>>> main
                        ? const Icon(
                            Icons.person,
                            size: 45,
                            color: Colors.grey,
                          )
                        : null,
                  ),
<<<<<<< HEAD
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
=======
                  GestureDetector(
                    onTap: pickImage,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 4),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(
                          alpha: 0.7,
                        ), // ✅ withOpacity
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "편집",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
>>>>>>> main
                        ),
                        const SizedBox(height: 6),
                        Text(_edited.customer_email),
                      ],
                    ),
                  ),
                ],
              ),
<<<<<<< HEAD

              const SizedBox(height: 24),

              // =========================
              // 이름 변경 버튼 (AlertDialog)
              // =========================
=======
              const SizedBox(height: 30),

              buildRow(
                "프로필 이름",
                profileNameController.text,
                true,
                () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("프로필 이름 변경"),
                      content: TextField(
                        controller: profileNameController,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("취소"),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {}); // ✅ UI 반영
                            Navigator.pop(context);
                          },
                          child: const Text("확인"),
                        ),
                      ],
                    ),
                  );
                },
              ),

              buildRow(
                "이름",
                widget.customer.customer_name,
                false,
                null,
              ),
              buildRow(
                "이메일",
                widget.customer.customer_email,
                false,
                null,
              ),

              const SizedBox(height: 30),
>>>>>>> main
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
<<<<<<< HEAD
                  onPressed: _saveAndClose,
                  child: const Text('저장'),
=======
                  onPressed: _saveProfile,
                  child: const Text("저장하기"),
>>>>>>> main
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

<<<<<<< HEAD
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
=======
  Widget buildRow(
    String title,
    String value,
    bool editable,
    VoidCallback? onEdit,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: const Color.fromARGB(
              255,
              247,
              157,
              157,
            ).withValues(alpha: 0.3), // ✅ withOpacity
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(value, style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
          if (editable)
            OutlinedButton(
              onPressed: onEdit,
              child: const Text("변경"),
            ),
        ],
      ),
>>>>>>> main
    );
  }
}
