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
    await Future.delayed(const Duration(seconds: 2));
    isSuccessful = true;
  }
}
class MakePayment extends StatefulWidget {
  final String paymentMethod;
  const MakePayment({super.key, required this.paymentMethod});
  @override
  _MakePaymentState createState() => _MakePaymentState();
}

class _MakePaymentState extends State<MakePayment> {
  String paymentMethod = ' ';
  bool paymentSuccess = false;
  Future<void> _makePayment() async {
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      paymentSuccess = true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[400],
        title: const Text('วิธีการชำระเงิน'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              'ช่องทางการชำระเงิน: $paymentMethod',
              style: const TextStyle(fontSize: 16),
            ),
            Column(
              children: <Widget>[
                RadioListTile(
                  title: const Text('ชำระเงินเป็นเงินสด'),
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
                  title: const Text('ชำระเงินผ่านบัตรเครดิต'),
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
                  title: const Text('ชำระเงินผ่านโอนเงินธนาคาร'),
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
         const SizedBox(height: 20),
         ElevatedButton(
          onPressed: () async {
            await _makePayment();
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
                          Navigator.of(context).popUntil((route) => route.isFirst);
                        }
                      },
                      child: const Text('เสร็จสิ้น'),

                    ),
                  ],
                );
              },
            );
          },
          style: ElevatedButton.styleFrom(
              primary: Colors.teal.shade400
          ),
          child: const Text('ชำระเงิน'),
        ),
          ],
        ),
      ),
    );
  }
}
