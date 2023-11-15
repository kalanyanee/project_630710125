import 'package:flutter/material.dart';

class Payment {
  final String paymentMethod;
  final double amount;
  final DateTime paymentDate;
  bool isSuccessful;

  Payment({
    required this.paymentMethod,
    required this.amount,
    required this.paymentDate,
    this.isSuccessful = false,
  });

  Future<void> makePayment() async {
    await Future.delayed(Duration(seconds: 2));
    isSuccessful = true;
  }
}
class MakePayment extends StatefulWidget {
  final String paymentMethod;
  MakePayment({required this.paymentMethod});
  @override
  _MakePaymentState createState() => _MakePaymentState();
}

class _MakePaymentState extends State<MakePayment> {
  String paymentMethod = 'เงินสด';
  bool paymentSuccess = false;
  Future<void> _makePayment() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      paymentSuccess = true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('วิธีการชำระเงิน'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'ช่องทางการชำระเงิน: $paymentMethod', // ใช้ตัวแปรที่กำหนดไว้
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
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () async {
            // เมื่อกดปุ่ม "ชำระเงิน"
            await _makePayment();
            // หลังจากชำระเงินเสร็จสิ้น, แสดงข้อความขอบคุณ
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(paymentSuccess ? 'ชำระเงินสำเร็จ' : 'ชำระเงินไม่สำเร็จ'),
                  content: Text(paymentSuccess
                      ? 'ขอบคุณที่ใช้บริการ!'
                      : 'กรุณาลองใหม่อีกครั้ง'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        if (paymentSuccess) {
                          // เมื่อกดปุ่มเสร็จสิ้นให้กลับไปที่หน้า Home Page
                          Navigator.of(context).popUntil((route) => route.isFirst);
                        }
                      },
                      child: Text('เสร็จสิ้น'),

                    ),
                  ],
                );
              },
            );
          },
          child: Text('ชำระเงิน'),
        ),
          ],
        ),
      ),
    );
  }
}
