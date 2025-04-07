import 'package:flutter/material.dart';
import 'health4.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Health Tips',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        fontFamily: 'Poppins',
      ),
      home: const HealthScreen3(),
    );
  }
}

class HealthScreen3 extends StatefulWidget {
  const HealthScreen3({super.key});

  @override
  _HealthScreenState createState() => _HealthScreenState();
}

class _HealthScreenState extends State<HealthScreen3> {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  String waterIntakeResult = '';
  bool showResult = false;

  // Calculate water intake based on weight and height
  void calculateWaterIntake() {
    if (weightController.text.isEmpty || heightController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter both weight and height'),
          backgroundColor: Color(0xFFB19589),
        ),
      );
      return;
    }

    try {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text);
      
      // Basic water intake calculation (weight in kg * 0.033 liters)
      double baseIntake = weight * 0.033;
      
      // Adjust for height (taller people may need slightly more)
      double heightFactor = height / 175.0; // 175 cm as reference height
      double adjustedIntake = baseIntake * heightFactor;
      
      // Round to 2 decimal places
      double finalIntake = double.parse(adjustedIntake.toStringAsFixed(2));
      
      setState(() {
        waterIntakeResult = '$finalIntake liters per day';
        showResult = true;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter valid numbers'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFEEE8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 30),
                // Header section with improved styling
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFB19589).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.water_drop_outlined,
                          color: Color(0xFFB19589),
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 15),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Health Tips!',
                            style: TextStyle(
                              fontSize: 24, 
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF333333),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Track your water Intake!',
                            style: TextStyle(
                              fontSize: 15, 
                              color: Color(0xFF666666),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                
                // Image Banner with enhanced styling
                Container(
                  width: 350,
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                    image: const DecorationImage(
                      image: AssetImage('assets/pics/health.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                
                // Card Section with improved styling
                Container(
                  width: 350,
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.calculate_outlined,
                            color: Color(0xFFB19589),
                            size: 22,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Calculate Water Intake',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF333333),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Enter your details to get personalized recommendation',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF666666),
                        ),
                      ),
                      const SizedBox(height: 25),
                      
                      // Input Fields with improved styling
                      TextField(
                        controller: weightController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Weight (KG)',
                          labelStyle: const TextStyle(
                            color: Color(0xFF666666),
                            fontSize: 14,
                          ),
                          prefixIcon: const Icon(
                            Icons.monitor_weight_outlined,
                            color: Color(0xFFB19589),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: const Color(0xFFB19589).withOpacity(0.5),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: Color(0xFFB19589),
                              width: 2,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: heightController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Height (CM)',
                          labelStyle: const TextStyle(
                            color: Color(0xFF666666),
                            fontSize: 14,
                          ),
                          prefixIcon: const Icon(
                            Icons.height_outlined,
                            color: Color(0xFFB19589),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: const Color(0xFFB19589).withOpacity(0.5),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: Color(0xFFB19589),
                              width: 2,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 25),
                      
                      // Result display
                      if (showResult)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            color: const Color(0xFFB19589).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: const Color(0xFFB19589).withOpacity(0.3),
                            ),
                          ),
                          child: Column(
                            children: [
                              const Text(
                                'Recommended Water Intake:',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF666666),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                waterIntakeResult,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFB19589),
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    size: 14,
                                    color: Color(0xFF666666),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'Based on your weight and height',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF666666),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      
                      // Calculate Button with improved styling
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: calculateWaterIntake,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFB19589),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 2,
                              ),
                              child: const Text(
                                'Calculate',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      
                      // Next button
                      TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HealthScreen4(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.arrow_forward,
                          size: 18,
                          color: Color(0xFFB19589),
                        ),
                        label: const Text(
                          'Continue to Water Tracker',
                          style: TextStyle(
                            color: Color(0xFFB19589),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                
                // Bottom Navigation Bar with improved styling
                Container(
                  width: 350,
                  height: 65,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildNavItem(Icons.home_outlined, 'Home', false),
                      _buildNavItem(Icons.bar_chart, 'Stats', false),
                      _buildNavItem(Icons.favorite, 'Health', true),
                      _buildNavItem(Icons.person_outline, 'Profile', false),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFFB09489) : Colors.transparent,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(
            icon,
            size: 24,
            color: isActive ? Colors.white : const Color(0xFF666666),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isActive ? const Color(0xFFB09489) : const Color(0xFF666666),
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
