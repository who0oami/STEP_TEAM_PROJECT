import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late TextEditingController emailcontroller;
  late TextEditingController pwcontroller;

  @override
  void initState() {
    super.initState();
    emailcontroller = TextEditingController();
    pwcontroller = TextEditingController();
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    pwcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //appBar: AppBar(title: Text('Home Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Text(
              'STEP',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'SMART TERMINAL FOR EVERY PURCHASE',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: emailcontroller,
                decoration: InputDecoration(
                  labelText: '이메일주소',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: pwcontroller,
                decoration: InputDecoration(
                  labelText: '비밀번호',
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                //GET.TO(Page());
              },
              child: Text('로그인'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text('회원가입'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                  ),
                ),
                Text('   |   '),
                TextButton(
                  onPressed: () {},
                  child: Text('이메일 찾기'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                  ),
                ),
                Text('   |   '),
                TextButton(
                  onPressed: () {},
                  child: Text('비밀번호 찾기'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 150),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text('이용약관'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('개인정보 처리방침'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
