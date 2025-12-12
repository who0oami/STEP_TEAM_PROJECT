import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:step_app/model/customer.dart';
import 'package:step_app/vm/database_handler_customer.dart';

class EditProfilePage extends StatefulWidget {
  final Customer customer;

  const EditProfilePage({super.key, required this.customer});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File? _profileImage;
  late TextEditingController profileNameController;

  bool _isPicking = false;
  late DatabaseHandlerCustomer handler; // ✅ 클래스명 수정

  @override
  void initState() {
    super.initState();
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
      );

      if (result != null) {
        setState(() {
          _profileImage = File(result.path);
        });
      }
    } finally {
      _isPicking = false;
    }
  }

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("프로필 관리"),
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[300],
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
                        ? const Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.grey,
                          )
                        : null,
                  ),
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
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveProfile,
                  child: const Text("저장하기"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
    );
  }
}
