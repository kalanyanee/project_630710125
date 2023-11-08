import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) { // ตรวจสอบว่า 'picked' ไม่เป็นค่า null ก่อนใช้
      String formattedDate = DateFormat('dd/MM/yyyy').format(picked);
      birthDateController.text = formattedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // ใช้ไอคอนลูกศรสีขาว
          onPressed: () {
            Navigator.of(context).pop(); // คำสั่งให้กลับไปหน้าก่อนหน้า
          },
        ),
        title: Text('โปรไฟล์'),

        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40),
            Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/images/profile.jpg'),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'ชื่อ',
                prefixIcon: Icon(Icons.account_circle),
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
              ),
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            TextField(
              controller: phoneNumberController,
              decoration: InputDecoration(
                hintText: 'เบอร์โทรศัพท์',
                prefixIcon: Icon(Icons.phone),
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
              ),
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'อีเมล์',
                prefixIcon: Icon(Icons.email),
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
              ),
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            TextField(
              controller: birthDateController,
              decoration: InputDecoration(
                hintText: 'วันเกิด',
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                prefixIcon: IconButton(
                  icon: Icon(Icons.cake),
                  onPressed: () => _selectDate(context),
                ),
              ),
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}