import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool all = false;
  bool fourteen = false;
  bool collect = false;
  bool marketing = false;

  late TextEditingController emailcontroller;
  late TextEditingController pwcontroller;
  late TextEditingController pwcheckcontroller;
  late TextEditingController namecontroller;
  late TextEditingController phonecontroller;

  @override
  void initState() {
    super.initState();
    emailcontroller = TextEditingController();
    pwcontroller = TextEditingController();
    pwcheckcontroller = TextEditingController();
    namecontroller = TextEditingController();
    phonecontroller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('회원가입'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        //titleTextStyle: TextStyle(
        //   fontSize: 20,
        //   fontWeight: FontWeight.bold,
        // ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text('이메일 주소'),
              TextField(controller: emailcontroller),
              Text('비밀번호'),
              TextField(controller: pwcontroller),
              Text('비밀번호 확인'),
              TextField(controller: pwcheckcontroller),
              Text('이름'),
              TextField(controller: namecontroller),
              Text('전화번호'),
              TextField(controller: phonecontroller),
              SizedBox(height: 50),
              //Checkbox(value: value, onChanged: onChanged)
              Row(
                children: [
                  //SizedBox(height: 50),
                  Checkbox(
                    value: all,
                    onChanged: (value) {
                      all = value!;
                      setState(() {});
                    },
                  ),
                  Text('모두 동의합니다'),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: fourteen,
                    onChanged: (value) {
                      fourteen = value!;
                      setState(() {});
                    },
                  ),
                  Text('[필수]만 14세 이상입니다'),
                ],
              ),

              Row(
                children: [
                  Checkbox(
                    value: collect,
                    onChanged: (value) {
                      collect = value!;
                      setState(() {});
                    },
                  ),
                  Text('[필수]이용 약관 동의'),
                ],
              ),

              Row(
                children: [
                  Checkbox(
                    value: collect,
                    onChanged: (value) {
                      collect = value!;
                      setState(() {});
                    },
                  ),
                  Text('[필수]개인정보 수집 및 이용 동의'),
                ],
              ),

              Row(
                children: [
                  Checkbox(
                    value: marketing,
                    onChanged: (value) {
                      marketing = value!;
                      setState(() {});
                    },
                  ),
                  Text('[동의]마케팅 수신 동의'),
                ],
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('가입하기'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
