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
    }
  }
}

class PackageAddress extends StatefulWidget {
  const PackageAddress({super.key});

  @override
  _PackageAddressState createState() => _PackageAddressState();
}

class _PackageAddressState extends State<PackageAddress> {
  final TextEditingController addressController = TextEditingController();
  String phone = '';
  int? selectedRoomSize = 0;
  int? selectedPackageDays = 4;
  late DateTime? selectedDate;
  late TimeOfDay? selectedTime;
  late PackageAddressData packageAddressData;
  bool isEnglishSelected = false;

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
                    packageAddressData.phone = value;
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'ใส่เบอร์โทรศัพท์',
                ),
              ),
              const SizedBox(height: 20),
              const Text(
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
                const Text('1-120 ตร.ม.'),
                Radio(
                  value: 121,
                  groupValue: selectedRoomSize,
                  onChanged: (value) {
                    setState(() {
                      selectedRoomSize = value;
                    });
                  },
                ),
                const Text('121-160 ตร.ม.'),
                Radio(
                  value: 161,
                  groupValue: selectedRoomSize,
                  onChanged: (value) {
                    setState(() {
                      selectedRoomSize = value;
                    });
                  },
                ),
                const Text('161-220 ตร.ม.'),
                Radio(
                  value: 221,
                  groupValue: selectedRoomSize,
                  onChanged: (value) {
                    setState(() {
                      selectedRoomSize = value;
                    });
                  },
                ),
                const Text('221-280 ตร.ม.'),
              ],
            ),

            const SizedBox(height: 20),
            const Text(
              'จำนวนวัน/เดือน:',
              style: TextStyle(fontSize: 16),
            ),
            Row(
              children: [
                for (int daysOption in [4, 5, 6, 7])
                  Padding(
                    padding: daysOption == 4
                        ? EdgeInsets.zero
                        : const EdgeInsets.only(bottom:0,left: 9),
                    child: Column(
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
                        const SizedBox(height: 10),
                        Padding(
                          padding: daysOption == 4
                              ? EdgeInsets.zero
                              : const EdgeInsets.only(left: 4),
                          child: Text('$daysOption วัน'),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
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
                  decoration: const InputDecoration(
                    hintText: 'เลือกเวลาที่นี่',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                );
              }),
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
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  packageAddressData.sendDataToApi();
                  showDialog(
                    context: context,
                    builder: (context) => Package(
                      address: addressController.text,
                      selectedRoomSize : selectedRoomSize,
                      selectedPackageDays:selectedPackageDays,
                      selectedDateTime: packageAddressData.workingHours,
                      phone: packageAddressData.phone,
                      isEnglishSelected: isEnglishSelected,

                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.teal.shade300
                ),
                child: const Text('ยืนยัน'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: PackageAddress(),
  ));
}
