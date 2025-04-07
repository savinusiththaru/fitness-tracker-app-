import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'health9.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Health Tips App',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        fontFamily: 'Roboto',
      ),
      home: const HealthScreen8(),
    );
  }
}

class HealthScreen8 extends StatefulWidget {
  const HealthScreen8({super.key});

  @override
  State<HealthScreen8> createState() => _HealthTipsScreenState();
}

class _HealthTipsScreenState extends State<HealthScreen8> {
  String? selectedPurpose = 'Cutting';
  final weightController = TextEditingController();
  final heightController = TextEditingController();

  @override
  void dispose() {
    weightController.dispose();
    heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFBE8E0),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      // Health Tips Title
                      Text(
                        'Health Tips!',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Calorie Intake Text
                      Text(
                        'Find recommended Calorie Intake!',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Main Card
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            // Image with Overlay Text
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24),
                                topRight: Radius.circular(24),
                              ),
                              child: Stack(
                                children: [
                                  Image.asset('assets/pics/health2.png',
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                  Container(
                                    height: 200,
                                    width: double.infinity,
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          Colors.black.withOpacity(0.7),
                                          Colors.transparent,
                                        ],
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Your',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'Personalised',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'Diet plan',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Enter Body Weight and the Height',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  // Weight and Height Form
                                  Container(
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Column(
                                      children: [
                                        // Weight Field
                                        Row(
                                          children: [
                                            Text('Enter weight: '),
                                            Expanded(
                                              child: TextField(
                                                controller: weightController,
                                                keyboardType: TextInputType.number,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter.digitsOnly,
                                                ],
                                                decoration: InputDecoration(
                                                  hintText: '___',
                                                  border: InputBorder.none,
                                                  contentPadding: EdgeInsets.zero,
                                                  isDense: true,
                                                ),
                                              ),
                                            ),
                                            Text('KG'),
                                          ],
                                        ),
                                        SizedBox(height: 12),
                                        // Height Field
                                        Row(
                                          children: [
                                            Text('Enter Height: '),
                                            Expanded(
                                              child: TextField(
                                                controller: heightController,
                                                keyboardType: TextInputType.number,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter.digitsOnly,
                                                ],
                                                decoration: InputDecoration(
                                                  hintText: '___',
                                                  border: InputBorder.none,
                                                  contentPadding: EdgeInsets.zero,
                                                  isDense: true,
                                                ),
                                              ),
                                            ),
                                            Text('CM'),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    'Select Your purpose of working out',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  // Purpose Selection
                                  Container(
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Column(
                                      children: [
                                        _buildRadioOption('Cutting'),
                                        SizedBox(height: 12),
                                        _buildRadioOption('Bulking'),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  // Continue Button
                                  Center(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // Navigation to WaterIntakePage
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>  HealthScreen9(),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFFB39B8E),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 32,
                                          vertical: 12,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                      ),
                                      child: Text(
                                        'Continue',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
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
            // Bottom Navigation Bar
            Container(
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(Icons.home_outlined, false),
                  _buildNavItem(Icons.bar_chart_outlined, false),
                  _buildNavItem(Icons.fitness_center_outlined, false),
                  _buildNavItem(Icons.favorite_outlined, true),
                  _buildNavItem(Icons.person_outline, false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioOption(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Radio(
          value: title,
          groupValue: selectedPurpose,
          activeColor: Color(0xFFB39B8E),
          onChanged: (value) {
            setState(() {
              selectedPurpose = value as String;
            });
          },
        ),
      ],
    );
  }

  Widget _buildNavItem(IconData icon, bool isSelected) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? Color(0xFFB39B8E) : Colors.transparent,
      ),
      padding: EdgeInsets.all(12),
      child: Icon(
        icon,
        size: 24,
        color: isSelected ? Colors.white : Colors.grey,
      ),
    );
  }
}