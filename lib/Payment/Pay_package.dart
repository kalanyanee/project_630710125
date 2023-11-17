import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Payment.dart';

class Package extends StatelessWidget {
  final String address;
  final DateTime selectedDateTime;
  final String phone;
  final bool isEnglishSelected;
  final int? selectedRoomSize;
  final int? selectedPackageDays;

  const Package({
    Key? key,
    required this.address,
    required this.selectedDateTime,
    required this.phone,
    required this.isEnglishSelected,
    required this.selectedRoomSize,
    required this.selectedPackageDays,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat("yyyy-MM-dd HH:mm").format(selectedDateTime);
    // คำนวณราคาตามเงื่อนไขที่กำหนด
    int totalAmount = 0;
    if (selectedRoomSize == 0) {
      if (selectedPackageDays == 4) {
        totalAmount = 9000;
      } else if (selectedPackageDays == 5) {
        totalAmount = 11200;
      } else if (selectedPackageDays == 6) {
        totalAmount = 13300;
      } else if (selectedPackageDays == 7) {
        totalAmount = 15750;
      }
    } else if (selectedRoomSize == 121) {
      if (selectedPackageDays == 4) {
        totalAmount = 11000;
      } else if (selectedPackageDays == 5) {
        totalAmount = 13750;
      } else if (selectedPackageDays == 6) {
        totalAmount = 16500;
      } else if (selectedPackageDays == 7) {
        totalAmount = 19250;
      }
    } else if (selectedRoomSize == 161) {
      if (selectedPackageDays == 4) {
        totalAmount = 14800;
      } else if (selectedPackageDays == 5) {
        totalAmount = 18500;
      } else if (selectedPackageDays == 6) {
        totalAmount = 22200;
      } else if (selectedPackageDays == 7) {
        totalAmount = 25900;
      }
    } else if (selectedRoomSize == 221) {
      if (selectedPackageDays == 4) {
        totalAmount = 16800;
      } else if (selectedPackageDays == 5) {
        totalAmount = 21500;
      } else if (selectedPackageDays == 6) {
        totalAmount = 25200;
      } else if (selectedPackageDays == 7) {
        totalAmount = 29900;
      }
    }

    DateTime startDate = selectedDateTime;
    startDate = startDate.add(Duration(days: selectedPackageDays ?? 0));
    List<Widget> dateWidgets = [];
    for (int index = 1; index < (selectedPackageDays ?? 0); index++) {
      DateTime dateToAdd = startDate.add(Duration(days: index));
      String formattedDate = DateFormat("yyyy-MM-dd HH:mm").format(dateToAdd);
      dateWidgets.add(Text('วันที่ ${index + 1}: $formattedDate'));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[300],
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
            Text('เลือกขนาดบ้าน: ${getRoomSizeText(selectedRoomSize)} ตร.ม'),
            const SizedBox(height: 20),
            const Text('เวลาจอง:'),
            const SizedBox(height: 20),
            Text('วันที่1: ${DateFormat("yyyy-MM-dd HH:mm").format(startDate)}'),
            ...dateWidgets,
            const SizedBox(height: 20),
            if (isEnglishSelected)
              const Text('พูดภาษาอังกฤษได้'),
            const SizedBox(height: 20),
            Text('ราคา: $totalAmount บาท'),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MakePayment(paymentMethod: 'yourPaymentMethod'),
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

  String getRoomSizeText(int? selectedRoomSize) {
    switch (selectedRoomSize) {
      case 0:
        return '1-120';
      case 121:
        return '121-160';
      case 161:
        return '161-220';
      case 221:
        return '221-280';
      default:
        return '';
    }
  }
}
