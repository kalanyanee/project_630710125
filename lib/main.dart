import 'package:flutter/material.dart';
import 'package:project/scressns.home/home_page.dart';

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
