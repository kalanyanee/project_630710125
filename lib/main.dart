import 'package:flutter/material.dart';
import 'package:project/screens.home/DeepCleaning_page.dart';
import 'package:project/screens.home/Package_page.dart';
import 'package:project/screens.home/Air_page.dart';
import 'package:project/screens.home/Profile_page.dart';
import 'package:project/screens.home/clean_page.dart';
import 'package:project/screens.home/home_page.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(), // เรียกใช้ HomePage จากไฟล์ home_page.dart
    );
  }
}
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send Data to Server'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            fetchDataFromServer(); // เปลี่ยนเป็นเรียกใช้ fetchDataFromServer หรือชื่อที่คุณต้องการ
          },
          child: Text('Fetch Data'),
        ),
      ),
    );
  }

  Future<void> fetchDataFromServer() async {
    try {
      final apiUrl = 'http://192.168.141.165:3354/addresses '; // ตรงนี้เป็น URL ของเซิร์ฟเวอร์ Dart ของคุณ
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        print('รับข้อมูลสำเร็จ: ${response.body}');
      } else {
        print('ไม่สามารถรับข้อมูลได้. รหัสสถานะ: ${response.statusCode}');
      }
    } catch (error) {
      print('เกิดข้อผิดพลาดในการรับข้อมูล: $error');
    }
  }
}
