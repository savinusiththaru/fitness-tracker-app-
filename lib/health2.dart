import 'package:flutter/material.dart';
import 'health3.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'SF Pro Display',
      ),
      home: const HealthScreen2(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HealthScreen2 extends StatelessWidget {
  const HealthScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFEEE8),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Health Tips!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Track your water intake!',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),

            // Main hydration card
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 4,
                color: Colors.black,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Card header with image
                    SizedBox(
                      height: 180,
                      child: Stack(
                        children: [
                          // Background image - Using a placeholder instead of AssetImage
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                            child: Container(
                              color: Colors.black45, // Fallback color
                              child: Image.asset('assets/pics/health-1.png',
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 180,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: double.infinity,
                                    height: 180,
                                    color: Colors.black45,
                                    child: const Center(
                                      child: Icon(Icons.water_drop, size: 60, color: Colors.white54),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          // Overlay for darkening
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                              color: Colors.black.withOpacity(0.3),
                            ),
                          ),
                          // Header text overlay
                          Positioned(
                            top: 16,
                            left: 16,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Stay Hydrated',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'And',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Stay Healthy',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Card content with light background
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(20),
                        ),
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Calculate your water intake!',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Water is essential for your body to function properly. Use this feature to log your daily water intake and ensure you\'re staying hydrated throughout the day. Aim for at least 8 glasses (2 liters) daily, or adjust based on your activity level and needs.',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              height: 1.47,
                              color: Colors.black.withOpacity(0.8),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                // Navigation to WaterIntakePage
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HealthScreen3(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFB19589),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                              ),
                              child: const Text(
                                'Calculate Water intake',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
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
            ),

            const Spacer(),

            // Bottom navigation bar
            Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(Icons.home_outlined, color: Colors.grey, size: 24),
                  const Icon(Icons.bar_chart, color: Colors.grey, size: 24),
                  const Icon(Icons.add_circle_outline, color: Colors.grey, size: 24),
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: const Color(0xFFB09489),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const Icon(Icons.person_outline, color: Colors.grey, size: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// New WaterIntakePage widget
class WaterIntakePage extends StatelessWidget {
  const WaterIntakePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Water Intake Calculator'),
        backgroundColor: const Color(0xFFB19589),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.water_drop, size: 60, color: Colors.blue),
            const SizedBox(height: 20),
            const Text(
              'Water Intake Calculator',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Enter your details to calculate your recommended daily water intake',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB19589),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}