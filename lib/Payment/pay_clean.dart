import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Payment.dart';

class PaymentClean extends StatelessWidget {
  final int machineCount;
  final int timeCount;
  final String address;
  final DateTime selectedDateTime;
  final String phone;
  final bool isEnglishSelected;
  final int additionalPrice;
  final int totalPrice;
  const PaymentClean({
    Key? key,
    required this.machineCount,
    required this.timeCount,
    required this.address,
    required this.selectedDateTime,
    required this.phone,
    required this.isEnglishSelected,
    required this.additionalPrice,
    required this.totalPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // คำนวณราคาทั้งหมด
    final SetTime = DateFormat("yyyy-MM-dd HH:mm");

    int calculatednalPricetime = additionalPrice;
    int calculatednalPriceroom = 0;
    int totalPrice = additionalPrice;

    if (timeCount >= 1) {
      calculatednalPricetime += timeCount * 500;
    }

    if (machineCount > 1) {
      calculatednalPriceroom += (machineCount-1 ) * 300;
    }
    totalPrice = (calculatednalPricetime + calculatednalPriceroom );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[300],
        title: const Text('กลับ'),
      ),
      body: Container(
        child: Padding(
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
              Text('เวลาจอง: ${SetTime.format(selectedDateTime)}'),
              const SizedBox(height: 20),
              Text('เวลาทำงาน: $timeCount  ชั่วโมง'),
              const SizedBox(height: 20),
              Text('จำนวนเห้อง: $machineCount ห้อง'),
              const Text('ราคาต่อห้อง: 300 บาท'),
              const SizedBox(height: 20),
              if (isEnglishSelected)
                const Text('พูดภาษาอังกฤษได้'),
              const SizedBox(height: 20),
              Text('ราคารวม: $totalPrice บาท'),
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
      ),
    );
  }
}
