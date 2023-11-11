import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Payment extends StatelessWidget {
  final int machineCount;
  final String address;
  final DateTime selectedDateTime;
  final String phone;
  // รับค่าจำนวนเครื่อง, ที่อยู่, และเวลามาจากหน้าก่อนหน้า
  const Payment({
    Key? key,
    required this.machineCount,
    required this.address,
    required this.selectedDateTime,
    required this.phone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // คำนวณราคาทั้งหมด
    int totalPrice = machineCount * 800;
    final SetTime = DateFormat("yyyy-MM-dd HH:mm");

    return Scaffold(
      appBar: AppBar(
        title: Text('กลับ'),
      ),
      body:Container (
        child: Padding(
          padding: const EdgeInsets.only(left: 20,top:10,right:0,bottom:10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text('ที่อยู่: ${address.toString()}'),
              SizedBox(height: 20),
              Text('เบอร์: $phone'),
              SizedBox(height: 20),
              Text('เวลาทำงาน: ${SetTime.format(selectedDateTime)}'),
              SizedBox(height: 20),
              Text('จำนวนเครื่อง: $machineCount เครื่อง'),
              Text('ราคาต่อเครื่อง: 800 บาท'),
              SizedBox(height: 20),
              Text('ราคารวม: $totalPrice บาท'),
              SizedBox(height: 20),

            ],
          ),
        ),
      ),
    );
  }
}

