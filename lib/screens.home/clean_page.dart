import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class CleanAddress extends StatefulWidget {
  @override
  _CleanAddressState createState() => _CleanAddressState();
}

class _CleanAddressState extends State<CleanAddress> {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController workingHoursController = TextEditingController();
  final TextEditingController englishController = TextEditingController(); // เพิ่มบรรทัดนี้
  int CountTime = 1;
  int CountRoom = 1;
  bool isEnglishSelected = false;
  String paymentMethod = '';

  _CleanAddressState() {
    isEnglishSelected = false; // กำหนดค่าเริ่มต้นเพิ่มเติม (หรือไม่ก็ได้)
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
            SizedBox(height: 20), // เพิ่มระยะห่าง
            Text(
              'เวลาจอง:',
              style: TextStyle(fontSize: 16),
            ),
            DateTimeField(
              format: DateFormat("yyyy-MM-dd HH:mm"), // กำหนดรูปแบบเวลา
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
                      initialTime: TimeOfDay.fromDateTime(currentValue ??
                          DateTime.now()),
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
                    if (CountTime > 1) {
                      setState(() {
                        CountTime--;
                      });
                    }
                  },
                ),
                Text(
                  CountTime.toString(),
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
                      CountTime++;
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
                    if (CountRoom > 1) {
                      setState(() {
                        CountRoom--;
                      });
                    }
                  },
                ),
                Text(
                  CountRoom.toString(),
                  style: TextStyle(fontSize: 16),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      CountRoom++;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20), // เพิ่มระยะห่าง
            Row(
              children: [
                Text(
                  'พูดภาษาอังกฤษ',
                  style: TextStyle(fontSize: 16),
                ),
                Checkbox(
                  value: isEnglishSelected,
                  // ตัวแปร isEnglishSelected ควรจะถูกกำหนดเป็น true หรือ false ตามการเลือกของผู้ใช้
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
            SizedBox(height: 20),
            Text(
              'ช่องทางการชำระเงิน:',
              style: TextStyle(fontSize: 16),
            ),
            Column(
              children: <Widget>[
                RadioListTile(
                  title: Text('ชำระเงินเป็นเงินสด'),
                  value: 'เงินสด',
                  groupValue: paymentMethod,
                  onChanged: (String? value) {
                    if (value != null) {
                      setState(() {
                        paymentMethod = value;
                      });
                    }
                  },
                ),
                RadioListTile(
                  title: Text('ชำระเงินผ่านบัตรเครดิต'),
                  value: 'บัตรเครดิต',
                  groupValue: paymentMethod,
                  onChanged: (String? value) {
                    if (value != null) {
                      setState(() {
                        paymentMethod = value;
                      });
                    }
                  },
                ),
                RadioListTile(
                  title: Text('ชำระเงินผ่านโอนเงินธนาคาร'),
                  value: 'โอนเงินธนาคาร',
                  groupValue: paymentMethod,
                  onChanged: (String? value) {
                    if (value != null) {
                      setState(() {
                        paymentMethod = value;
                      });
                    }
                  },
                ),
              ],
            ),
            Center(
              child:ElevatedButton(
                onPressed: () {
                  // ตรวจสอบค่าที่อยู่, เวลาทำงาน, จำนวนห้อง, การเลือกภาษาอังกฤษ, และช่องทางการชำระเงิน
                  String address = addressController.text;
                  DateTime workingHours = DateTime.now(); // ลบการเรียก DateTimeField.defaultSavedDate
                  int roomCount = CountRoom;
                  // ไม่ต้องประกาศตัวแปร isEnglishSelected อีกครั้ง

                  // ตรวจสอบความถูกต้องของข้อมูล
                  if (address.isEmpty) {
                    // ถ้าที่อยู่ว่างเปล่า
                    // แสดงข้อความแจ้งเตือนผู้ใช้
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('คำอธิบายข้อผิดพลาด'),
                          content: Text('โปรดกรอกที่อยู่'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('ปิด'),
                            ),
                          ],
                        );
                      },
                    );
                  } else if (workingHours.isBefore(DateTime.now())) {
                    // ถ้าเวลาทำงานอยู่ในอดีต
                    // แสดงข้อความแจ้งเตือนผู้ใช้
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('คำอธิบายข้อผิดพลาด'),
                          content: Text('เวลาทำงานต้องอยู่ในอนาคต'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('ปิด'),
                            ),
                          ],
                        );
                      },
                    );
                  } else if (roomCount < 1) {
                    // ถ้าจำนวนห้องน้อยกว่า 1
                    // แสดงข้อความแจ้งเตือนผู้ใช้
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('คำอธิบายข้อผิดพลาด'),
                          content: Text('จำนวนห้องต้องมากกว่าหรือเท่ากับ 1'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('ปิด'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    // ถ้าข้อมูลถูกต้อง, คุณสามารถดำเนินการตามที่คุณต้องการ
                    // ตัวอย่าง: ส่งข้อมูลไปยังเซิร์ฟเวอร์หรือแสดงข้อความยืนยันอื่น ๆ
                  }
                },
                child: Text('ยืนยัน'), // กดยืนยันให้ไปหน้าคำนวนเงินที่ต้องจ่าย
              ),


            )
          ],
        ),
      ),
    ),
    );
  }
  void main() {
    runApp(MaterialApp(
      home: CleanAddress(),
    )
    );
  }
}