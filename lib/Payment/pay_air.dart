import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Payment.dart'; // นำเข้า MakePayment ที่ถูกต้อง

class PaymentAir extends StatelessWidget {

  final int machineCount;
  final String address;
  final DateTime selectedDateTime;
  final String phone;
  final bool isEnglishSelected;
  final int additionalPrice;
  final int totalPrice;
  static const int additionalPriceValue = 800;

  const PaymentAir({
    Key? key,

    required this.machineCount,
    required this.address,
    required this.selectedDateTime,
    required this.phone,
    required this.isEnglishSelected,
    required this.additionalPrice,
    required this.totalPrice,
  }) : super(key: key);

  int calculateAdditionalPrice() {
    return machineCount * additionalPriceValue;
  }

  @override
  Widget build(BuildContext context) {
    final SetTime = DateFormat("yyyy-MM-dd HH:mm");
    int additionalPrice = calculateAdditionalPrice();

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
            Text('เวลาทำงาน: ${SetTime.format(selectedDateTime)}'),
            SizedBox(height: 20),
            Text('จำนวนเครื่อง: $machineCount เครื่อง'),
            Text('ราคาต่อเครื่อง: 800 บาท'),
            SizedBox(height: 20),
            if (isEnglishSelected)
              Text('พูดภาษาอังกฤษได้'),
            SizedBox(height: 20),
            Text('ราคารวม: ${totalPrice + additionalPrice} บาท'),
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
