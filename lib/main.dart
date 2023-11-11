import 'package:flutter/material.dart';
import 'package:project/screens.home/DeepCleaning_page.dart';
import 'package:project/screens.home/Package_page.dart';
import 'package:project/screens.home/Air_page.dart';
import 'package:project/screens.home/Profile_page.dart';
import 'package:project/screens.home/clean_page.dart';
import 'package:project/screens.home/home_page.dart';

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
