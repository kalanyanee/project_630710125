import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../Payment/pay_air.dart';

class AirAddressData {
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

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'workingHours': workingHours.toIso8601String(),
      'machineCount': machineCount,
      'isEnglishSelected': isEnglishSelected,
      'phone': phone,
    };
  }
  Future<void> sendDataToApi() async {
    const apiUrl = 'http://192.168.141.192/addresses';
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode(toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('ส่งข้อมูลสำเร็จ');
      } else {
        print('ไม่สามารถส่งข้อมูลได้. รหัสสถานะ: ${response.statusCode}');

      }
    } catch (error) {
      //print('เกิดข้อผิดพลาดในการส่งข้อมูล: $error');
      // แสดงข้อความข้อผิดพลาดหรือดำเนินการเพิ่มเติมตามต้องการ
    }
  }
}

class AirAddress extends StatefulWidget {
  const AirAddress({super.key});
  @override
  _AirAddressState createState() => _AirAddressState();
}

class _AirAddressState extends State<AirAddress> {
  int machineCount = 1;
  bool isEnglishSelected = false;
  late AirAddressData airAddressData;

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
        backgroundColor: Colors.teal[300],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('กลับ'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'ที่อยู่:',
                style: TextStyle(fontSize: 16),
              ),
              TextField(
                maxLines: null,
                onChanged: (value) {
                  setState(() {
                    airAddressData.address = value;
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'ใส่รายละเอียดที่อยู่ของคุณที่นี่',
                ),
              ),
              const SizedBox(height: 20),
              const Text(
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
                decoration: const InputDecoration(
                  hintText: 'ใส่เบอร์โทรศัพท์',
                ),
              ),
              const SizedBox(height: 20),
              const Text(
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
                decoration: const InputDecoration(
                  hintText: 'เลือกเวลาที่นี่',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'จำนวนเครื่อง:',
                style: TextStyle(fontSize: 16),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
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
                    style: const TextStyle(fontSize: 16),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        machineCount++;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text(
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
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal.shade300
                  ),
                  child: const Text('ยืนยัน'),
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
  final airAddressData = AirAddressData(
    address: '',
    workingHours: DateTime.now(),
    machineCount: 1,
    isEnglishSelected: false,
    phone: '',
  );

  await airAddressData.sendDataToApi();

  runApp(const MaterialApp(
    home: AirAddress(),
  ));
}
