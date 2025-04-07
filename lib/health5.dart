import 'package:flutter/material.dart';
import 'health6.dart';

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
      home: const HealthScreen5(),
    );
  }
}

class HealthScreen5 extends StatelessWidget {
  const HealthScreen5({super.key});

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
                      // Body Fat Percentage Card
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
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
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              ),
                              child: Stack(
                                children: [
                                  Image.network(
                                    'https://images.unsplash.com/photo-1534438327276-14e5300c3a48',
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
                                          'Find Your Body',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'Fat Percentage',
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
                                    'Calculate your body fat!',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Calculating your body fat percentage helps you understand your overall health and fitness level better than weight alone. It provides insight into your body composition, helping you track progress, set realistic goals, and tailor your workouts and nutrition for optimal results',
                                    style: TextStyle(
                                      fontSize: 16,
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
                                            builder: (context) =>  HealthScreen6(),
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
                                        'Calculate Body Fat Percentage',
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
              height: 80,
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
                  _buildNavItem(Icons.home_outlined, true),
                  _buildNavItem(Icons.bar_chart_outlined, false),
                  _buildNavItem(Icons.fitness_center_outlined, false),
                  _buildNavItem(
                    Icons.favorite_outlined, 
                    false, 
                    isSelected: true
                  ),
                  _buildNavItem(Icons.person_outline, false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, bool isHome, {bool isSelected = false}) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? Color(0xFFB39B8E) : Colors.transparent,
      ),
      padding: EdgeInsets.all(12),
      child: Icon(
        icon,
        size: 24,
        color: isSelected 
            ? Colors.white 
            : isHome 
                ? Colors.black 
                : Colors.grey,
      ),
    );
  }
}