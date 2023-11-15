import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../Payment/pay_clean.dart';
import 'package:flutter/services.dart';

class CleanAddressData {
  String address;
  DateTime workingHours;
  int roomCount;
  int timeCount;
  bool isEnglishSelected;
  String phone;

  CleanAddressData({
    required this.address,
    required this.workingHours,
    required this.roomCount,
    required this.timeCount,
    required this.isEnglishSelected,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'workingHours': workingHours.toUtc().toIso8601String(),
      'roomCount': roomCount,
      'timeCount': timeCount,
      'isEnglishSelected': isEnglishSelected,
      'phone': phone,
    };
  }
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

class CleanAddress extends StatefulWidget {
  @override
  _CleanAddressState createState() => _CleanAddressState();
}

class _CleanAddressState extends State<CleanAddress> {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  int countTime = 1;
  int countRoom = 1;
  bool isEnglishSelected = false;
  DateTime? selectedDateTime;
  late CleanAddressData cleanAddressData;

  @override
  void initState() {
    super.initState();
    cleanAddressData = CleanAddressData(
      address: '',
      workingHours: DateTime.now(),
      roomCount: 1,
      timeCount: 1,
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
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () async {
              await sendDataToApi(cleanAddressData);
              print(jsonEncode(cleanAddressData.toJson()));
              showDialog(
                context: context,
                builder: (context) => PaymentClean(
                  machineCount: countRoom,
                  address: addressController.text,
                  selectedDateTime: cleanAddressData.workingHours,
                  phone: phoneController.text,
                  isEnglishSelected: isEnglishSelected,
                  timeCount: countTime,
                  additionalPrice: 0,
                  totalPrice: 0,
                ),
              );
            },
          ),
        ],
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
                controller: addressController,
                maxLines: 1,
                onChanged: (value) {
                  setState(() {
                    cleanAddressData.address = value;
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
                    cleanAddressData.phone = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'ใส่เบอร์โทรศัพท์',
                ),
              ),
              SizedBox(height: 20),
              Text(
                'เวลาจอง:',
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
                        cleanAddressData.workingHours = DateTime(
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
                'เวลาทำงาน:',
                style: TextStyle(fontSize: 16),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      if (countTime > 1) {
                        setState(() {
                          countTime--;
                        });
                      }
                    },
                  ),
                  Text(
                    countTime.toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    ' ชั่วโมง',
                    style: TextStyle(fontSize: 16),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        countTime++;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'จำนวนห้อง:',
                style: TextStyle(fontSize: 16),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      if (countRoom > 1) {
                        setState(() {
                          countRoom--;
                        });
                      }
                    },
                  ),
                  Text(
                    countRoom.toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        countRoom++;
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
                    cleanAddressData.sendDataToApi();
                    // หลังจากที่ส่งข้อมูลสำเร็จ แสดง Dialog หรือทำตามต้องการ
                    //int additionalPrice = 0;

                    showDialog(
                      context: context,
                      builder: (context) => PaymentClean(
                        machineCount: countRoom,
                        address: addressController.text,
                        selectedDateTime: cleanAddressData.workingHours,
                        phone: phoneController.text,
                        isEnglishSelected: isEnglishSelected,
                        timeCount: countTime,
                        additionalPrice: 0,
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

Future<void> sendDataToApi(CleanAddressData data) async {
  final apiUrl = 'http://192.168.141.192/addresses';

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode(data.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print('ส่งข้อมูลสำเร็จ');
    } else {
      print('ไม่สามารถส่งข้อมูลได้. รหัสสถานะ: ${response.statusCode}');
    }
  } catch (error) {
    //print('เกิดข้อผิดพลาดในการส่งข้อมูล: $error');
  }
}

void main() {
  runApp(MaterialApp(
    home: CleanAddress(),
  ));
}
