import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class DeepAddress extends StatefulWidget {
  @override
  _DeepAddressState createState() => _DeepAddressState();
}

class _DeepAddressState extends State<DeepAddress> {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController workingHoursController = TextEditingController();
  final TextEditingController englishController = TextEditingController(); // เพิ่มบรรทัดนี้
  bool isEnglishSelected = false;
  String paymentMethod = '';
  String houseSize = '';
  _DeepAddressState() {
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
    body: SingleChildScrollView( //รองรับเนื้อหาที่ยาวเกินขนาดหน้าจอได้
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  'ขนาดบ้าน:',
                  style: TextStyle(fontSize: 16),
                ),
                RadioListTile(
                  title: Text('1-120 ตร.ม.'),
                  value: '1-120',
                  groupValue: houseSize, // houseSize ควรเป็นตัวแปรที่ใช้เก็บค่าขนาดบ้านที่เลือก
                  onChanged: (String? value) {
                    if (value != null) {
                      setState(() {
                        houseSize = value;
                      });
                    }
                  },
                ),
                RadioListTile(
                  title: Text('121-160 ตร.ม.'),
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
                  title: Text('161-220 ตร.ม.'),
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
                  title: Text('221-280 ตร.ม.'),
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
  //           SizedBox(height: 20),
  //           Text(
  //             'ช่องทางการชำระเงิน:',
  //             style: TextStyle(fontSize: 16),
  //           ),
  //           Column(
  //             children: <Widget>[
  //               RadioListTile(
  //                 title: Text('ชำระเงินเป็นเงินสด'),
  //                 value: 'เงินสด',
  //                 groupValue: paymentMethod,
  //                 onChanged: (String? value) {
  //                   if (value != null) {
  //                     setState(() {
  //                       paymentMethod = value;
  //                     });
  //                   }
  //                 },
  //               ),
  //               RadioListTile(
  //                 title: Text('ชำระเงินผ่านบัตรเครดิต'),
  //                 value: 'บัตรเครดิต',
  //                 groupValue: paymentMethod,
  //                 onChanged: (String? value) {
  //                   if (value != null) {
  //                     setState(() {
  //                       paymentMethod = value;
  //                     });
  //                   }
  //                 },
  //               ),
  //               RadioListTile(
  //                 title: Text('ชำระเงินผ่านโอนเงินธนาคาร'),
  //                 value: 'โอนเงินธนาคาร',
  //                 groupValue: paymentMethod,
  //                 onChanged: (String? value) {
  //                   if (value != null) {
  //                     setState(() {
  //                       paymentMethod = value;
  //                     });
  //                   }
  //                 },
  //               ),
  //             ],
  //           ),
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
  void main() {
    runApp(MaterialApp(
      home: DeepAddress(),
    )
    );
  }
}