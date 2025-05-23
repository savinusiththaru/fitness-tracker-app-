import 'package:flutter/material.dart';
import 'health8.dart';

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
      home: const HealthScreen7(),
    );
  }
}

class HealthScreen7 extends StatelessWidget {
  const HealthScreen7({super.key});

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
                      // Streak Information
                      RichText(
                        text: TextSpan(
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          children: [
                            TextSpan(text: 'You are on a '),
                            TextSpan(
                              text: '3 day',
                              style: TextStyle(
                                color: Colors.brown,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(text: ' Streak! Keep it up!'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Diet Plan Card
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
                                    'Get Best DietPlan for Your Body',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    'Create personalised meal plans tailored to your fitness goals and dietary preferences. Explore nutritious recipes, track your daily intake, and stay on track to achieve a healthier, balanced lifestyle. Start fueling your body the right way today!',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
                                      height: 1.5,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Center(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // Navigation to WaterIntakePage
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>  HealthScreen8(),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFFB39B8E),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 24,
                                          vertical: 12,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                      ),
                                      child: Text(
                                        'Check out Diet plan',
                                        style: TextStyle(
                                          fontSize: 14,
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