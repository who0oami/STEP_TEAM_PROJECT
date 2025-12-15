import 'package:flutter/material.dart';
import 'package:step_app/util/message.dart';
import 'package:step_app/util/scolor.dart';
import 'package:get/get.dart';
import 'package:step_app/view/app/home.dart';

enum RefundReason { changeOfMind, productIssue, other }

class RefundProductDetail extends StatefulWidget {
  const RefundProductDetail({super.key});

  @override
  State<RefundProductDetail> createState() =>
      _RefundProductDetailState();
}

class _RefundProductDetailState extends State<RefundProductDetail> {
  //property
  RefundReason? _selected = RefundReason.changeOfMind;
  late TextEditingController refundTextController;

  @override
  void initState() {
    super.initState();
    refundTextController = TextEditingController();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PColor.baseBackgroundColor,
      appBar: AppBar(
        title: const Text(
          '반품 신청',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
        ),
        backgroundColor: PColor.appBarBackgroundColor,
        toolbarHeight: 70,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 50, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '반품 상품',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              height: 130,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: PColor.appBarBackgroundColor,
              ),
              child: Row(
                children: [
                  Image.asset('images/AIR+FORCE+4.png'),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'product name',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'product brand',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF999999),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Text(
                            'product price',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Text(
                '어떤 문제가 있나요?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: PColor.appBarBackgroundColor,
              ),
              child: Column(
                children: [
                  RadioGroup<RefundReason>(
                    groupValue: _selected,
                    onChanged: (value) {
                      setState(() {
                        _selected = value!;
                      });
                    },
                    child: Column(
                      children: [
                        ...RefundReason.values.map((reason) {
                          return RadioListTile<RefundReason>(
                            title: Text(
                              _label(reason),
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black.withAlpha(180),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            value: reason,
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (_selected == RefundReason.other)
              Container(
                margin: const EdgeInsets.only(top: 12),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: PColor.appBarBackgroundColor,
                ),
                child: TextField(
                  controller: refundTextController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: '기타 사유를 입력해주세요',
                    border: InputBorder.none,
                  ),
                ),
              ),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsetsGeometry.fromLTRB(16, 0, 16, 20),
        child: ElevatedButton(
          onPressed: () {
            if (_selected == RefundReason.other &&
                refundTextController.text.isEmpty) {
              Message().snackBar('알림', '기타 사유를 입력해주세요');
              return;
            }
            Message().showDialog(
              '완료',
              '반품 신청이 완료되었습니다.',
            ); // 수정 필요 홈으로 가도록
            // Home으로 이동 (스택 전부 정리하고 홈만 남김)
            Get.offAll(() => Home());
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: PColor.buttonPrimary,
            foregroundColor: PColor.buttonTextColor,
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(12),
            ),
          ),
          child: Text('반품 신청', style: TextStyle(fontSize: 16)),
        ),
      ),
    );
  } // build
  //  ==== functions ====

  String _label(RefundReason refundReason) {
    switch (refundReason) {
      case RefundReason.changeOfMind:
        return '단순 변심';
      case RefundReason.productIssue:
        return '상품 문제';
      case RefundReason.other:
        return '기타';
    }
  }
} // class
