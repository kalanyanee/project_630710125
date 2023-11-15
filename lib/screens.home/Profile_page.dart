import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // เรียกเมธอด _loadProfile เมื่อ Widget ถูกสร้าง
    _loadProfile();
  }

  // เมธอดสำหรับโหลดข้อมูลโปรไฟล์จาก SharedPreferences
  Future<void> _loadProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // โหลดข้อมูลจาก SharedPreferences
      nameController.text = prefs.getString('name') ?? '';
      phoneNumberController.text = prefs.getString('phoneNumber') ?? '';
      emailController.text = prefs.getString('email') ?? '';
      birthDateController.text = prefs.getString('birthDate') ?? '';
    });
  }

  // เมธอดสำหรับบันทึกข้อมูลโปรไฟล์ลงใน SharedPreferences
  Future<void> _saveProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // บันทึกข้อมูลลงใน SharedPreferences
    prefs.setString('name', nameController.text);
    prefs.setString('phoneNumber', phoneNumberController.text);
    prefs.setString('email', emailController.text);
    prefs.setString('birthDate', birthDateController.text);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      String formattedDate = DateFormat('dd/MM/yyyy').format(picked);
      setState(() {
        birthDateController.text = formattedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            _saveProfile(); // เมื่อกลับหน้าก่อนหน้าให้ทำการบันทึกโปรไฟล์
            Navigator.of(context).pop();
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
            TextFormField(
              controller: birthDateController,
              decoration: InputDecoration(
                hintText: 'วันเกิด',
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                prefixIcon: Icon(Icons.cake),
              ),
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
              onTap: () => _selectDate(context), // แสดงปฏิทินเมื่อแตะ
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                bool confirm = await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('ยืนยันการบันทึก'),
                      content: Text('คุณต้องการบันทึกข้อมูลโปรไฟล์นี้หรือไม่?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false); // ปิดกล่องโต้ตอบและส่งค่า false
                          },
                          child: Text('ไม่'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(true); // ปิดกล่องโต้ตอบและส่งค่า true
                          },
                          child: Text('ใช่'),
                        ),
                      ],
                    );
                  },
                );

                if (confirm == true) {
                  _saveProfile(); // บันทึกข้อมูลเมื่อผู้ใช้ยืนยัน
                  Navigator.of(context).pop(); // กลับหน้าก่อนหน้า
                }
              },
              child: Text('บันทึก'),
            ),
          ],
        ),
      ),
    );
  }
}
