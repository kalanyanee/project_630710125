import 'package:flutter/material.dart';
import 'package:project/scressns.home/DeepCleaning_page.dart';
import 'package:project/scressns.home/Package_page.dart';
import 'package:project/scressns.home/Air_page.dart';
import 'package:project/scressns.home/Profile_page.dart';
import 'package:project/scressns.home/clean_page.dart';
import 'package:project/scressns.home/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CleanAddress(), // เรียกใช้ HomePage จากไฟล์ home_page.dart
    );
  }
}
