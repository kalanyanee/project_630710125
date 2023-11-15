import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Payment.dart';

class PaymentDeepClean extends StatelessWidget {
  final String address;
  final DateTime selectedDateTime;
  final String phone;
  final bool isEnglishSelected;
  final String houseSize;

  const PaymentDeepClean({
    Key? key,
    required this.address,
    required this.selectedDateTime,
    required this.phone,
    required this.isEnglishSelected,
    required this.houseSize,
  }) : super(key: key);

  int calculatePrice(String houseSize) {
    switch (houseSize) {
      case '1-120':
        return 2250;
      case '121-160':
        return 2750;
      case '161-220':
        return 3750;
      case '221-280':
        return 4250;
      default:
        return 0; // ราคาเริ่มต้นหรือการจัดการกรณีที่จำเป็น
    }
  }

  @override
  Widget build(BuildContext context) {
    // คำนวณราคารวมตามขนาดบ้านที่เลือก
    final totalAmount = calculatePrice(houseSize);

    // กำหนดรูปแบบวันที่
    final formattedDate = DateFormat("yyyy-MM-dd HH:mm").format(selectedDateTime);

    return Scaffold(
      appBar: AppBar(
        title: Text('กลับ'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 10, right: 0, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text('ที่อยู่: ${address.toString()}'),
            SizedBox(height: 20),
            Text('เบอร์: $phone'),
            SizedBox(height: 20),
            Text('เลือกขนาดบ้าน: $houseSize ตร.ม'),
            SizedBox(height: 20),
            Text('เวลาจอง: $formattedDate'),
            SizedBox(height: 20),
            Text('ราคา: $totalAmount บาท'),
            SizedBox(height: 20),
          ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MakePayment(paymentMethod: 'yourPaymentMethod'),
              ),
            );
          },
            child: Text('ยืนยันการชำระเงิน'),
        ),
          ],
        ),
      ),
    );
  }
}
