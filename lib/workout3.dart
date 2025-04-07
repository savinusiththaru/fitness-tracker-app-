import 'package:flutter/material.dart';
import 'workout4.dart';

void main() {
  runApp(const WorkoutApp());
}

class WorkoutApp extends StatelessWidget {
  const WorkoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workout App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'SF Pro Display',
        scaffoldBackgroundColor: const Color(0xFFF8E8E0),
      ),
      home: const WorkoutScreen(),
    );
  }
}

class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top image with exercise label
              Stack(
                children: [
                  // Background image with workout person
                  Image.asset('assets/pics/workout2.png',
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  
                  // Back button
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  
                  // Exercise label and set information
                  Positioned(
                    bottom: 16,
                    left: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Exercise',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Set 01 <01/10>',
                          style: TextStyle(
                            color: Colors.grey[300],
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              // Main content with peach background
              Container(
                color: const Color(0xFFF8E8E0),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Body Building header
                    const Text(
                      'Body Building',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Full Body Workout',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Day 01 and description
                    const Text(
                      'Day 01',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'lose fat and warm p with some basic Exercises avnva d l ni ns . sn sin ds s clx clikdk lm c n n sl.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    // Level and Time
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Level',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Beginner',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          color: Colors.grey[300],
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Time',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '40 Mins',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    const Divider(height: 40),
                    
                    // You'll Need section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'You\'ll Need',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '5 items',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    // Equipment row
                    Row(
                      children: [
                        _buildEquipmentItem('Barbell'),
                        const SizedBox(width: 12),
                        _buildEquipmentItem('Skipping Rope'),
                        const SizedBox(width: 12),
                        _buildEquipmentItem('Bottle 1 Liters'),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Daily Task section
                    const Text(
                      'Daily Task',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    
                    // Set 1
                    const Text(
                      'Set 1',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    // Exercise list for Set 1
                    _buildExerciseItem('Warm Up', '05:00'),
                    _buildExerciseItem('Jumping Jack', '12x'),
                    _buildExerciseItem('Skipping', '15x'),
                    _buildExerciseItem('Squats', '20x'),
                    _buildExerciseItem('Arm Raises', '00:53'),
                    _buildExerciseItem('Rest and Drink', '02:00'),
                    
                    const SizedBox(height: 16),
                    
                    // Set 2
                    const Text(
                      'Set 2',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    // Exercise list for Set 2
                    _buildExerciseItem('Incline Push-Ups', '12x'),
                    _buildExerciseItem('Push-Ups', '15x'),
                    _buildExerciseItem('Skipping', '15x'),
                    _buildExerciseItem('Cobra Stretch', '20x'),
                    
                    const SizedBox(height: 24),
                    
                    // Start Workout button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const ExerciseScreen()),
                              );
                            },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFC4A99A),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          'Start Workout',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEquipmentItem(String name) {
    return Expanded(
      child: Column(
        children: [
          Container(
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Icon(
                name == 'Barbell' ? Icons.fitness_center :
                name == 'Skipping Rope' ? Icons.loop :
                Icons.water_drop,
                size: 32,
                color: Colors.black54,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseItem(String name, String count) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          // Exercise image placeholder
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            // In a real app, you'd place actual images here
            child: Center(
              child: Icon(
                name.contains('Warm') ? Icons.fitness_center :
                name.contains('Jump') ? Icons.accessibility_new :
                name.contains('Skip') ? Icons.loop :
                name.contains('Squat') ? Icons.accessibility :
                name.contains('Arm') ? Icons.sports_gymnastics :
                name.contains('Rest') ? Icons.local_drink :
                name.contains('Push') ? Icons.arrow_downward :
                name.contains('Cobra') ? Icons.airline_seat_flat : 
                Icons.fitness_center,
                color: Colors.grey[600],
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                Text(
                  count,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }
}