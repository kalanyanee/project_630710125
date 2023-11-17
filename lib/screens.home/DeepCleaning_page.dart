import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../Payment/pay_deepcleaning.dart';

class DeepAddressData {
  String address;
  DateTime workingHours;
  String houseSize;
  String phone;
  bool isEnglishSelected;

  DeepAddressData({
    required this.address,
    required this.workingHours,
    required this.houseSize,
    required this.phone,
    required this.isEnglishSelected,
  });

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'workingHours': workingHours.toIso8601String(),
      'isEnglishSelected': isEnglishSelected,
      'phone': phone,
      'houseSize' : houseSize,
    };
  }Future<void> sendDataToApi() async {
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
    }
  }
}

class DeepAddress extends StatefulWidget {
  const DeepAddress({super.key});

  @override
  _DeepAddressState createState() => _DeepAddressState();
}

class _DeepAddressState extends State<DeepAddress> {
  final TextEditingController addressController = TextEditingController();
  bool isEnglishSelected = false;
  String houseSize = '';
  DateTime? selectedDateTime;
  late DeepAddressData deepAddressData;

  @override
  void initState() {
    super.initState();
    deepAddressData = DeepAddressData(
      address: '',
      workingHours: DateTime.now(),
      houseSize: '',
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
                controller: addressController,
                maxLines: 1,
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
                    deepAddressData.phone = value;
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'ใส่เบอร์โทรศัพท์',
                ),
              ),
              const SizedBox(height: 20),
              const Text(
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
                        deepAddressData.workingHours = DateTime(
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'ขนาดบ้าน:',
                    style: TextStyle(fontSize: 16),
                  ),
                  RadioListTile(
                    title: const Text('1-120 ตร.ม.'),
                    value: '1-120',
                    groupValue: houseSize,
                    onChanged: (String? value) {
                      if (value != null) {
                        setState(() {
                          houseSize = value;
                        });
                      }
                    },
                  ),
                  RadioListTile(
                    title: const Text('121-160 ตร.ม.'),
                    value: '121-160',
                    groupValue: houseSize,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          houseSize = value;
                        });
                      }
                    },
                  ),
                  RadioListTile(
                    title: const Text('161-220 ตร.ม.'),
                    value: '161-220',
                    groupValue: houseSize,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          houseSize = value;
                        });
                      }
                    },
                  ),
                  RadioListTile(
                    title: const Text('221-280 ตร.ม.'),
                    value: '221-280',
                    groupValue: houseSize,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          houseSize = value;
                        });
                      }
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
                    deepAddressData.sendDataToApi();
                    showDialog(
                      context: context,
                      builder: (context) => PaymentDeepClean(
                        address: addressController.text,
                        houseSize : houseSize,
                        selectedDateTime: deepAddressData.workingHours,
                        phone: deepAddressData.phone,
                        isEnglishSelected: isEnglishSelected,
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
void main() {
  runApp(const MaterialApp(
    home: DeepAddress(),
  ));
}
