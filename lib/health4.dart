import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Tips',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
      ),
      home: HealthScreen4(),
    );
  }
}

class HealthScreen4 extends StatelessWidget {
  HealthScreen4({super.key});

  final List<String> waterBenefits = [
    "Improves Performance",
    "Regulates Temperature",
    "Reduces Muscle Cramps",
    "Faster Recovery",
    "Enhances Mental Focus",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFEEE8),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 88),
                      const Text(
                        'Health Tips!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const Text(
                        'Track your water intake!',
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 23),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 4,
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Image.asset(
                                  'assets/pics/health-1.png',
                                  height: 222,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                                const Positioned(
                                  top: 10,
                                  left: 24,
                                  child: Text(
                                    '',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const Positioned(
                                  top: 50,
                                  left: 215,
                                  child: Text(
                                    '',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: const TextSpan(
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                      children: [
                                        TextSpan(text: 'Drink '),
                                        TextSpan(
                                          text: '5L of Water',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        TextSpan(text: ' a day to stay healthy and hydrated.'),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  ...waterBenefits.map(
                                    (benefit) => Padding(
                                      padding: const EdgeInsets.only(bottom: 4),
                                      child: Text(
                                        benefit,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          height: 1.47,
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
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Container(
                    height: 53,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Icon(Icons.home, size: 26),
                        const Icon(Icons.bar_chart, size: 24),
                       
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFFB09489),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.favorite,
                              color: Colors.black,
                              size: 26,
                            ),
                          ),
                        ),
                        const Icon(Icons.person, size: 24),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    width: 94,
                    height: 1,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
