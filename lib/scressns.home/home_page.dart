import 'package:flutter/material.dart';
import 'package:project/scressns.home/DeepCleaning_page.dart';
import 'package:project/scressns.home/Package_page.dart';
import 'package:project/scressns.home/Air_page.dart';
import 'package:project/scressns.home/clean_page.dart';

import 'Profile_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double borderRadius = 10.0; // ความโค้งขอบ
    const double borderWidth = 1.0; // ความหนาขอบ
    const double shadowBlurRadius = 3.0; // รัศมีความเบลอของเงา

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          backgroundColor: Colors.green[300],
          title: Container(
            margin: EdgeInsets.all(20),
            child: Text(
              'ยินดีต้อนรับ',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ),
          centerTitle: true,
          leading: InkWell(

            child: Icon(
              Icons.account_circle, // ใช้ไอคอนลูกศรสีขาว
              size: 40,
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProfilePage(), // นำทางไปยังหน้า DeepAddress
              ));
            },
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AirAddress(), // นำทางไปยังหน้า AirAddress
                      ));
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: 240, // ปรับความกว้าง
                          height: 270, // ปรับความสูง
                          decoration: BoxDecoration(
                            color: Colors.white, //สีกล่อง
                            borderRadius: BorderRadius.circular(borderRadius),
                            border: Border.all(
                              color: Colors.green.shade100, // เปลี่ยนสีขอบตามที่ต้องการ
                              width: 2, // ปรับความหนาขอบตามที่ต้องการ
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Image.asset(
                            'assets/images/air.png',
                            fit: BoxFit.contain, // ปรับขนาดให้พอดีกับ Container
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Text(
                              'ทำความสะอาดเครื่องปรับอากาศ',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CleanAddress(), // นำทางไปยังหน้า CleanAddress
                      ));
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: 240,
                          height: 270,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(borderRadius),
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.green.shade100, // เปลี่ยนสีขอบตามที่ต้องการ
                              width: 2, // ปรับความหนาขอบตามที่ต้องการ
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Image.asset(
                            'assets/images/mop.png', // แทน 'assets/image2.png' ด้วยเส้นทางของรูปภาพที่คุณต้องการใช้
                            fit: BoxFit.contain,
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Image.asset(
                            'assets/images/mop.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Text(
                              'ทำความสะอาดบ้าน',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Align(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DeepAddress(), // นำทางไปยังหน้า DeepAddress
                      ));
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: 240,
                          height: 270,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.green.shade100, // เปลี่ยนสีขอบตามที่ต้องการ
                              width: 2, // ปรับความหนาขอบตามที่ต้องการ
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Image.asset(
                            'assets/images/home.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Text(
                              'Deep Cleaning',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PackageAddress(), // นำทางไปยังหน้า PackageAddress
                      ));
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: 240,
                          height: 270,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.green.shade100, // เปลี่ยนสีขอบตามที่ต้องการ
                              width: 2, // ปรับความหนาขอบตามที่ต้องการ
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Image.asset(
                            'assets/images/calendar.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Text(
                              'จองงานแบบแพ็คเกจ',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}
