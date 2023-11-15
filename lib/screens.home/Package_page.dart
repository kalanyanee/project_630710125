import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../Payment/Pay_package.dart';

class PackageAddressData {
  String address;
  DateTime workingHours;
  int? selectedRoomSize;
  int? selectedPackageDays;
  String phone;
  bool isEnglishSelected;

  PackageAddressData({
    required this.address,
    required this.workingHours,
    required this.selectedRoomSize,
    required this.phone,
    required this.isEnglishSelected,
    required this.selectedPackageDays,
  });

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'workingHours': workingHours.toUtc().toIso8601String(),
      'selectedRoomSize':selectedRoomSize,
      'selectedPackageDays':selectedPackageDays,
      'isEnglishSelected': isEnglishSelected,
      'phone': phone,
    };
  }
}

class PackageAddress extends StatefulWidget {
  @override
  _PackageAddressState createState() => _PackageAddressState();
}

class _PackageAddressState extends State<PackageAddress> {
  final TextEditingController addressController = TextEditingController();
  String phone = ''; // เปลี่ยนจาก PackageAddress.phone เป็นตัวแปรอินสแตนซ์
  int? selectedRoomSize = 0; // ขนาดห้องเริ่มต้น
  int? selectedPackageDays = 4; // แพ็คเกจเริ่มต้น (2 วัน)
  late DateTime? selectedDate; // ตัวแปรในการเก็บวันที่ที่เลือก
  late TimeOfDay? selectedTime; // ตัวแปรในการเก็บเวลาที่เลือก
  late PackageAddressData packageAddressData;

  @override
  void initState() {
    super.initState();
    packageAddressData = PackageAddressData(
      address: '',
      workingHours: DateTime.now(),
      selectedRoomSize: 0,
      selectedPackageDays: 2,
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
                    packageAddressData.phone = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'ใส่เบอร์โทรศัพท์',
                ),
              ),
              SizedBox(height: 20),
              Text(
                'ขนาดห้อง/บ้าน:',
                style: TextStyle(fontSize: 16),
              ),
            Row(
              children: [
                Radio(
                  value: 0,
                  groupValue: selectedRoomSize,
                  onChanged: (value) {
                    setState(() {
                      selectedRoomSize = value;
                    });
                  },
                ),
                Text('1-120 ตร.ม.'),
                Radio(
                  value: 121,
                  groupValue: selectedRoomSize,
                  onChanged: (value) {
                    setState(() {
                      selectedRoomSize = value;
                    });
                  },
                ),
                Text('121-160 ตร.ม.'),
                Radio(
                  value: 161,
                  groupValue: selectedRoomSize,
                  onChanged: (value) {
                    setState(() {
                      selectedRoomSize = value;
                    });
                  },
                ),
                Text('161-220 ตร.ม.'),
                Radio(
                  value: 221,
                  groupValue: selectedRoomSize,
                  onChanged: (value) {
                    setState(() {
                      selectedRoomSize = value;
                    });
                  },
                ),
                Text('221-280 ตร.ม.'),
              ],
            ),

            SizedBox(height: 20),
            Text(
              'จำนวนวัน/เดือน:',
              style: TextStyle(fontSize: 16),
            ),
            Row(
              children: [
                for (int daysOption in [4, 5, 6, 7]) // รายการวันที่เลือก
                  Column(
                    children: [
                      Radio(
                        value: daysOption,
                        groupValue: selectedPackageDays,
                        onChanged: (value) {
                          setState(() {
                            selectedPackageDays = value;
                          });
                        },
                      ),
                      Text('$daysOption วัน'),
                    ],
                  ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'เวลาจอง:',
              style: TextStyle(fontSize: 16),
            ),
            Column(
              children: List.generate(selectedPackageDays ?? 0, (index) {
                return DateTimeField(
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
                        initialTime: TimeOfDay.fromDateTime(
                          currentValue ?? DateTime.now(),),
                      );
                      if (selectedTime != null) {
                        setState(() {
                          packageAddressData.workingHours = DateTime(
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
                );
              }),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  sendDataToApi(packageAddressData);
                  showDialog(
                    context: context,
                    builder: (context) => Package(
                      address: addressController.text,
                      selectedRoomSize : selectedRoomSize,
                      selectedPackageDays:selectedPackageDays,
                      selectedDateTime: packageAddressData.workingHours,
                      phone: packageAddressData.phone,
                      isEnglishSelected: packageAddressData.isEnglishSelected,

                    ),
                  );
                },

                child: Text('ยืนยัน'),//กดยืนยันให้ไปหน้าคำนวนเงินที่ต้องจ่าย
              ),
            )

          ],

        ),
      ),
      ),
    );
  }
}

Future<void> sendDataToApi(PackageAddressData data) async {
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
    home: PackageAddress(),
  ));
}
