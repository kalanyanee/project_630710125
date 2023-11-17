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
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalAmount = calculatePrice(houseSize);
    final formattedDate = DateFormat("yyyy-MM-dd HH:mm").format(selectedDateTime);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[400],
        title: const Text('กลับ'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 10, right: 0, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text('ที่อยู่: ${address.toString()}'),
            const SizedBox(height: 20),
            Text('เบอร์: $phone'),
            const SizedBox(height: 20),
            Text('เลือกขนาดบ้าน: $houseSize ตร.ม'),
            const SizedBox(height: 20),
            Text('เวลาจอง: $formattedDate'),
            const SizedBox(height: 20),
            if (isEnglishSelected)
              const Text('พูดภาษาอังกฤษได้'),
            const SizedBox(height: 20),
            Text('ราคารวม: $totalAmount บาท'),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MakePayment(paymentMethod: ''),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.teal.shade400
                ),
                child: const Text('ยืนยันการชำระเงิน'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
