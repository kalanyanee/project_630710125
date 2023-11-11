import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class PackageAddress extends StatefulWidget {
  @override
  _PackageAddressState createState() => _PackageAddressState();
}
class _PackageAddressState extends State<PackageAddress> {
  final TextEditingController addressController = TextEditingController();
  int? selectedRoomSize = 0; // Default room size
  int? selectedPackageDays = 2; // แพ็คเกจเริ่มต้น (2 วัน)
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
        title: Text('กลับ'),
      ),
      body:SingleChildScrollView(
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
                Text('0-120 ตร.ม.'),
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
              'จำนวนวัน/สัปดาห์:',
              style: TextStyle(fontSize: 16),
            ),
            Row(
              children: [
                for (int daysOption in [2, 3, 4, 5, 6, 7]) // รายการวันที่เลือก
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
                          initialTime: TimeOfDay.fromDateTime(
                            currentValue ?? DateTime.now(),
                          ),
                        ).then((selectedTime) {
                          if (selectedTime != null) {
                            DateTime selectedDateTime = DateTime(
                              selectedDate.year,
                              selectedDate.month,
                              selectedDate.day,
                              selectedTime.hour,
                              selectedTime.minute,
                            );
                            return selectedDateTime;
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
                );
              }),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // ทำตรวจสอบและประมวลผลข้อมูลที่ผู้ใช้กรอก แล้วดำเนินการตามที่คุณต้องการ
                  // ตรวจสอบค่าที่อยู่, เวลาทำงาน, จำนวนเครื่อง, การเลือกภาษาอังกฤษ, และช่องทางการชำระเงิน
                  // ถ้าข้อมูลถูกต้อง, คุณสามารถดำเนินการตามที่คุณต้องการ หรือแสดงข้อความยืนยันอื่น ๆ
                  // และถ้าข้อมูลไม่ถูกต้อง, คุณสามารถแสดงข้อความแจ้งเตือนผู้ใช้
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
