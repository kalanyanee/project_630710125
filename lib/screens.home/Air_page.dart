import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../Payment/pay_air.dart';

class AirAddressData { // เก็บข้อมูลที่เกี่ยวข้องที่อยู่model
  String address;
  DateTime workingHours;
  int machineCount;
  bool isEnglishSelected;
  String phone;

  AirAddressData({
    required this.address,
    required this.workingHours,
    required this.machineCount,
    required this.isEnglishSelected,
    required this.phone,
  });

  Map<String, dynamic> toJson() { //เพื่อแปลงข้อมูลทั้งหมดในอ็อบเจกต์นี้เป็นรูปแบบ JSON
    return {
      'address': address,// เพิ่มที่อยู่เข้าไปใน JSON
      'workingHours': workingHours.toIso8601String(), // เพิ่มที่อยู่เข้าไปใน JSON
      'machineCount': machineCount, // เพิ่มจำนวนเครื่องเข้าไปใน JSON
      'isEnglishSelected': isEnglishSelected, // เพิ่มสถานะการเลือกภาษาอังกฤษเข้าไปใน JSON
      'phone': phone, // เพิ่มเบอร์โทรศัพท์เข้าไปใน JSON
    };
  }//เมื่อเรียกใช้ toJson() จะได้ผลลัพธ์เป็น Map ที่เก็บข้อมูลทั้งหมดในรูปแบบ JSON ซึ่งสามารถนำไปใช้ในการส่งข้อมูลไปยัง API หรือบันทึกในฐานข้อมูล JSON ได้.
  Future<void> sendDataToApi() async {//ใช้ส่งข้อมูลที่เก็บในอ็อบเจกต์ AirAddressData ไปยัง API ที่กำหนด.
    final apiUrl = 'http://192.168.141.192/addresses';
    try {// ตรวจสอบข้อมูลเพิ่มเติมตามต้องการ
      final response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode(toJson()), // แปลงข้อมูลในรูปแบบ JSON และส่งไปยัง API
        headers: {'Content-Type': 'application/json'},//เพื่อบอก API ว่าข้อมูลที่ส่งมาเป็น JSON.
      );

      if (response.statusCode == 200) {
        print('ส่งข้อมูลสำเร็จ');
      } else {
        print('ไม่สามารถส่งข้อมูลได้. รหัสสถานะ: ${response.statusCode}');
        // แสดงข้อความข้อผิดพลาดหรือดำเนินการเพิ่มเติมตามต้องการ
      }
    } catch (error) {
     // print('เกิดข้อผิดพลาดในการส่งข้อมูล: $error');
      // แสดงข้อความข้อผิดพลาดหรือดำเนินการเพิ่มเติมตามต้องการ
    }
  }
}

class AirAddress extends StatefulWidget {//แสดงหน้าจอสำหรับกรอกข้อมูลที่จะส่งไปยัง API และทำการนำข้อมูลไปแสดงผลใน widget อื่น เช่น หน้าตะกร้าสินค้า, หน้าแสดงการชำระเงิน, หรือหน้าอื่น ๆ ตามที่ได้กำหนด.
  @override
  _AirAddressState createState() => _AirAddressState();
}

class _AirAddressState extends State<AirAddress> { //เป็นส่วนที่เก็บสถานะ (state) ของ AirAddress widget.
  int machineCount = 1; //เก็บจำนวนเครื่องที่ผู้ใช้เลือก. เริ่มต้นที่ 1.
  bool isEnglishSelected = false; //เก็บสถานะใช้ได้เลือกให้แสดงข้อความเป็นภาษาอังกฤษหรือไม่ (true ถ้าเลือก, false ถ้าไม่เลือก).
  late AirAddressData airAddressData; //เพื่อเก็บข้อมูลที่ผู้ใช้กรอก เช่น ที่อยู่, เวลาทำงาน, เบอร์โทรศัพท์

  @override
  void initState() {
    super.initState();
    airAddressData = AirAddressData(
      address: '',
      workingHours: DateTime.now(),
      machineCount: 1,
      isEnglishSelected: false,
      phone: '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('กลับ'),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.shopping_cart),
        //     onPressed: () async {
        //       // นำไปยังหน้าตะกร้าหรือที่คุณต้องการ
        //       airAddressData.sendDataToApi();  // แก้ไขนี้
        //       // ตรวจสอบการส่งข้อมูลเสร็จสิ้นก่อนทำการแสดง Dialog
        //       print(jsonEncode(airAddressData.toJson()));  // แสดงข้อมูลที่จะถูกส่งไป
        //       int additionalPrice = 0;
        //
        //       showDialog(
        //         context: context,
        //         builder: (context) => PaymentAir(
        //           machineCount: machineCount,
        //           address: airAddressData.address,
        //           selectedDateTime: airAddressData.workingHours,
        //           phone: airAddressData.phone,
        //           isEnglishSelected: isEnglishSelected,
        //           additionalPrice: additionalPrice,
        //           totalPrice: 0,  // ใส่ราคารวมที่ต้องการแสดง
        //         ),
        //       );
        //     },
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ที่อยู่:',
                style: TextStyle(fontSize: 16),
              ),
              TextField(
                maxLines: 1,
                onChanged: (value) {
                  setState(() {
                    airAddressData.address = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'ใส่รายละเอียดที่อยู่ของคุณที่นี่',
                ),
              ),
              SizedBox(height: 20),
              Text(
                'เบอร์:',
                style: TextStyle(fontSize: 16),
              ),
              TextField(
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  LengthLimitingTextInputFormatter(10),
                ],
                onChanged: (value) {
                  setState(() {
                    airAddressData.phone = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'ใส่เบอร์โทรศัพท์',
                ),
              ),
              SizedBox(height: 20),
              Text(
                'เวลาทำงาน:',
                style: TextStyle(fontSize: 16),
              ),
              DateTimeField(
                format: DateFormat("yyyy-MM-dd HH:mm"),
                onShowPicker: (context, currentValue) async {
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    firstDate: DateTime(2000),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  if (selectedDate != null) {
                    TimeOfDay? selectedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                    );
                    if (selectedTime != null) {
                      setState(() {
                        airAddressData.workingHours = DateTime(
                          selectedDate.year,
                          selectedDate.month,
                          selectedDate.day,
                          selectedTime.hour,
                          selectedTime.minute,
                        );
                      });
                      return DateTime(
                        selectedDate.year,
                        selectedDate.month,
                        selectedDate.day,
                        selectedTime.hour,
                        selectedTime.minute,
                      );
                    }
                  }
                  return currentValue;
                },
                decoration: InputDecoration(
                  hintText: 'เลือกเวลาที่นี่',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'จำนวนเครื่อง:',
                style: TextStyle(fontSize: 16),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      if (machineCount > 1) {
                        setState(() {
                          machineCount--;
                        });
                      }
                    },
                  ),
                  Text(
                    machineCount.toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        machineCount++;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'พูดภาษาอังกฤษ',
                    style: TextStyle(fontSize: 16),
                  ),
                  Checkbox(
                    value: isEnglishSelected,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          isEnglishSelected = value;
                        });
                      }
                    },
                  ),
                ],
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    airAddressData.sendDataToApi();
                    // หลังจากที่ส่งข้อมูลสำเร็จ แสดง Dialog หรือทำตามต้องการ
                    int additionalPrice = 0;

                    showDialog(
                      context: context,
                      builder: (context) => PaymentAir(
                        machineCount: machineCount,
                        address: airAddressData.address,
                        selectedDateTime: airAddressData.workingHours,
                        phone: airAddressData.phone,
                        isEnglishSelected: isEnglishSelected,
                        additionalPrice: additionalPrice,
                        totalPrice: 0,
                      ),
                    );
                  },
                  child: Text('ยืนยัน'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() async {
  // สร้าง instance ของ AirAddressData
  final airAddressData = AirAddressData(
    address: 'Your Address',
    workingHours: DateTime.now(),
    machineCount: 1,
    isEnglishSelected: false,
    phone: 'Your Phone',
  );

  // เรียกใช้ sendDataToApi
  await airAddressData.sendDataToApi();

  runApp(MaterialApp(
    home: AirAddress(),
  ));
}
