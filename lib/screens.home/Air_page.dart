import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import '../Model/air_model.dart';
import '../Payment/pay_payment.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class AirAddress extends StatefulWidget {
  @override
  _AirAddressState createState() => _AirAddressState();
}

class _AirAddressState extends State<AirAddress> {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController workingHoursController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  int machineCount = 1;
  bool isEnglishSelected = false;
  String paymentMethod = '';

  late AirAddressData airAddressData = AirAddressData(
    address: '',
    workingHours: DateTime.now(),
    machineCount: 1,
    isEnglishSelected: false,
    phone: '', // ต้องใส่ค่า phone ที่เหมาะสมที่นี่
  );
  late Map<String, dynamic> jsonData;

  @override
  void initState() {
    super.initState();
    jsonData = {
      "address": " ",
      "phone" : " ",
      "workingHours": "2023-12-01 08:00",
      "englishSelected": false,
    };
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
                  // เมื่อมีการเปลี่ยนแปลงในช่องที่อยู่
                  setState(() {
                    airAddressData.address = value; // อัปเดตค่า address ในข้อมูลที่เก็บ
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
                controller: phoneController,
                keyboardType: TextInputType.phone,
                // กำหนด keyboardType เป็น phone
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  LengthLimitingTextInputFormatter(10),
                  // จำกัดจำนวนตัวอักษรที่ใส่ได้เป็น 10 ตัว
                ],
                onChanged: (value) {
                  // เมื่อมีการเปลี่ยนแปลงในช่องเบอร์โทรศัพท์
                  setState(() {
                    airAddressData.phone = value; // อัปเดตค่า phone ในข้อมูลที่เก็บ
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
                onShowPicker: (context, currentValue) {
                  return showDatePicker(
                    context: context,
                    firstDate: DateTime(2000),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2101),
                  ).then((selectedDate) {
                    if (selectedDate != null) {
                      return showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                      ).then((selectedTime) {
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
                        } else {
                          return currentValue;
                        }
                      });
                    } else {
                      return currentValue;
                    }
                  });
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
                  onPressed: () async {
                    // บันทึกข้อมูลที่กรอก
                    saveData();

                    // ส่งข้อมูลไปยัง API
                    await sendDataToApi(jsonData);

                    // นำทางไปยังหน้าถัดไป
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Payment(
                          address: airAddressData.address,
                          selectedDateTime: airAddressData.workingHours,
                          machineCount: machineCount,
                          phone: airAddressData.phone,
                        ),
                      ),
                    );
                  },
                  child: Text('ยืนยัน'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void saveData() {
    // อัปเดต jsonData ด้วยข้อมูลที่กรอก
    jsonData = {
      'address': airAddressData.address,
      'workingHours': airAddressData.workingHours.toString(),
      'englishSelected': airAddressData.isEnglishSelected,
      'phone': airAddressData.phone, // เพิ่ม phone ใน jsonData
    };
    // คุณสามารถบันทึก jsonData ไปยังที่เก็บข้อมูลที่คุณต้องการ (เช่น SharedPreferences, ไฟล์, ฐานข้อมูล) ที่นี่
  }

  Future<void> sendDataToApi(Map<String, dynamic> data) async {
    final apiUrl = 'YOUR_API_URL'; // แทนที่ YOUR_API_URL ด้วย URL ของ API ที่คุณใช้

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('Data sent successfully');
      } else {
        print('Failed to send data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error sending data: $error');
    }
  }

  void main() {
    runApp(MaterialApp(
      home: AirAddress(),
    ));
  }
}
