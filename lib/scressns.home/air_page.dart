import 'package:flutter/material.dart';

class AirAddress extends StatelessWidget {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('กลับ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ที่อยู่:',
              style: TextStyle(fontSize: 16),
            ),
            TextField(
              controller: addressController,
              maxLines: 1,
              decoration: InputDecoration(
                hintText: 'ใส่รายละเอียดที่อยู่ของคุณที่นี่',
              ),
            ),
            SizedBox(height: 20), // เพิ่มระยะห่าง
            Text(
              'เวลาทำงาน:',
              style: TextStyle(fontSize: 16),
            ),
            TextField(
              controller: timeController,
              decoration: InputDecoration(
                hintText: 'วว/ดด/ปป เวลา:',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AirAddress(),
  ));
}
