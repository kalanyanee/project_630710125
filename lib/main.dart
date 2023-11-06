import 'package:flutter/material.dart';

void main() {
  runApp(WelcomeApp());
}

class WelcomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[200],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          backgroundColor: Colors.green,
          title: Container(
            margin: EdgeInsets.all(20),
            child: Text(
              'วันนี้คุณเป็นอย่างไรบ้าง?',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // กรอบพื้นหลังสีแดง
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20), // กำหนดความโค้ง
                  ),
                ),
                SizedBox(width: 10), // ระยะห่างระหว่างกรอบ
                // กรอบพื้นหลังสีเขียว
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20), // กำหนดความโค้ง
                  ),
                ),
              ],
            ),
            SizedBox(height: 10), // ระยะห่างระหว่างแถวขอบตัวแรกและตัวที่ 2
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // กรอบพื้นหลังสีฟ้า
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20), // กำหนดความโค้ง
                  ),
                ),
                SizedBox(width: 10), // ระยะห่างระหว่างกรอบ
                // กรอบพื้นหลังสีเหลือง
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(20), // กำหนดความโค้ง
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
