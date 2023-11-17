import 'package:flutter/material.dart';
import 'package:project/screens.home/DeepCleaning_page.dart';
import 'package:project/screens.home/Package_page.dart';
import 'package:project/screens.home/Air_page.dart';
import 'package:project/screens.home/clean_page.dart';
import 'Profile_page.dart';

class HomePage extends StatelessWidget {
   HomePage({Key? key}) : super(key: key);
  final List<Map<String, dynamic>> sections = [
    {
      'image': 'assets/images/air.png',
      'text': 'ทำความสะอาดเครื่องปรับอากาศ',
      'route': const AirAddress(),
    },
    {
      'image': 'assets/images/mop.png',
      'text': 'ทำความสะอาดบ้าน',
      'route': const CleanAddress(),
    },
    {
      'image': 'assets/images/home.png',
      'text': 'Deep Cleaning',
      'route': const DeepAddress(),
    },
    {
      'image': 'assets/images/calendar.png',
      'text': 'จองงานแบบแพ็คเกจ',
      'route': const PackageAddress(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    const double borderRadius = 10.0;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: Colors.teal[300],
          title: Container(
            margin: const EdgeInsets.all(20),
            child: const Text(
              'ยินดีต้อนรับ',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ),
          centerTitle: true,
          leading: InkWell(
            child: const Icon(
              Icons.account_circle,
              size: 40,
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProfilePage(),
              ));
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AirAddress(),
                      ));
                    },
                    child: Container(
                      width: 240,
                      height: 270,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(borderRadius),
                        border: Border.all(
                          color: Colors.teal.shade100,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 3,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0, //สูง
                            left: 0, //ซ้าย
                            right: 0, //ขวา
                            bottom: 0, //ล่าง
                            child: Image.asset(
                              'assets/images/air.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          const Positioned(
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
                  ),
                  const SizedBox(width: 15),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const CleanAddress(),
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
                              color: Colors.teal.shade100,
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 3,
                                offset: const Offset(0, 3),
                              ),
                            ],
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
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Image.asset(
                            'assets/images/mop.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        const Positioned(
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
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const DeepAddress(),
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
                              color: Colors.teal.shade100,
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 3,
                                offset: const Offset(0, 3),
                              ),
                            ],
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
                        const Positioned(
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
                  const SizedBox(width: 15),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const PackageAddress(),
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
                              color: Colors.teal.shade100,
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 3,
                                offset: const Offset(0, 3),
                              ),
                            ],
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
                        const Positioned(
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
            ],
          ),
        ),
      ),
    );
  }
}
    void main() {
      runApp(MaterialApp(
        home: HomePage(), //
      ));
    }
