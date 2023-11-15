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
      calculatednalPriceroom += (machineCount - 1) * 300; // ห้องที่ 2 เป็นต้นไป คิดเพิ่ม 300 บาทต่อห้อง
    }

    totalPrice = (calculatednalPricetime + calculatednalPriceroom );

    return Scaffold(
      appBar: AppBar(
        title: Text('กลับ'),
      ),
      body: Container(
        child: Padding(
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
              Text('เวลาจอง: ${SetTime.format(selectedDateTime)}'),
              SizedBox(height: 20),
              Text('เวลาทำงาน: $timeCount  ชั่วโมง'),
              SizedBox(height: 20),
              Text('จำนวนเห้อง: $machineCount ห้อง'),
              Text('ราคาต่อห้อง: 300 บาท'),
              SizedBox(height: 20),
              if (isEnglishSelected) // ตรวจสอบว่าถูกเลือกในการพูดภาษาอังกฤษหรือไม่
                Text('พูดภาษาอังกฤษได้'),
              SizedBox(height: 20),
              Text('ราคารวม: $totalPrice บาท'),
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
      ),
    );
  }
}
