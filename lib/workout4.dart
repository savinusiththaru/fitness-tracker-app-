import 'dart:async';
import 'package:flutter/material.dart';
import 'workout5.dart';

void main() {
  runApp(const FitnessApp());
}

class FitnessApp extends StatelessWidget {
  const FitnessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness Timer App',
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: const Color(0xFF1E1E1E),
      ),
      home: const ExerciseScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({super.key});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  int timeRemaining = 300; // 5 minutes in seconds
  Timer? timer;
  String currentExercise = "Warm Up";
  String nextExercise = "Jumping Jack";
  int currentSet = 1;
  int totalSets = 10;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeRemaining > 0) {
        setState(() {
          timeRemaining--;
        });
      } else {
        timer.cancel();
        moveToNextExercise();
      }
    });
  }

  void moveToNextExercise() {
    setState(() {
      currentExercise = nextExercise;
      nextExercise = "Cool Down"; // Just an example
      timeRemaining = 300; // Reset timer
    });
    startTimer();
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    // Calculate progress for the circular indicator (0 to 1)
    double progress = 1 - (timeRemaining / 300);
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.85),
        ),
        child: Column(
          children: [
            // Header section with background
            Container(
              height: MediaQuery.of(context).size.height * 0.35,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/pics/workout4.png'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.2),
                    BlendMode.darken,
                  ),
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Back button
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(Icons.chevron_left, color: Colors.white, size: 30),
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Daily Task title
                      const Center(
                        child: Text(
                          'Daily Task',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Exercise title and set info
                      Center(
                        child: Column(
                          children: [
                            const Text(
                              'Exercise',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Set 01 • 01/10',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 14,
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
            
            // Main content (timer card)
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFF0EB),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    
                    // Exercise name
                    Text(
                      currentExercise,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    
                    const SizedBox(height: 40),
                    
                    // Timer with circular progress
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Background circle
                          Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                          ),
                          
                          // Progress indicator
                          SizedBox(
                            height: 200,
                            width: 200,
                            child: CircularProgressIndicator(
                              value: progress,
                              strokeWidth: 15,
                              backgroundColor: const Color(0xFFEEEEEE),
                              valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
                            ),
                          ),
                          
                          // Timer text
                          Center(
                            child: Text(
                              formatTime(timeRemaining),
                              style: const TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 40),
                    
                    // Descriptive text
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 36),
                      child: Text(
                        'Exercise warm-ups are low-intensity activities before workouts that increase heart rate, improve flexibility, and reduce injury risk.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),
                    ),
                    
                    const Spacer(),
                    
                    // Next exercise section - now clickable
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const WorkoutScreen1()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Column(
                          children: [
                            Text(
                              'Next>>',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 1),
                            const Text(
                              'Jumping Jack',
                              style: TextStyle(
                                fontSize: 20,
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
              ),
            ),
          ],
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        height: 54,
        margin: const EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 16,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              child: const Icon(Icons.home_outlined),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AnalyticsPage()),
                );
              },
              child: const Icon(Icons.bar_chart),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ExercisePage()),
                );
              },
              child: Stack(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Color(0xFFB09489),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.fitness_center,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FavoritesPage()),
                );
              },
              child: const Icon(Icons.favorite_border),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
              child: const Icon(Icons.person_outline),
            ),
          ],
        ),
      ),
    );
  }
}

// Dummy page classes for navigation - you should replace these with your actual pages
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const Center(child: Text('Home Page')),
    );
  }
}

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Analytics')),
      body: const Center(child: Text('Analytics Page')),
    );
  }
}

class ExercisePage extends StatelessWidget {
  const ExercisePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercise')),
      body: const Center(child: Text('Exercise Page')),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: const Center(child: Text('Favorites Page')),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: const Center(child: Text('Profile Page')),
    );
  }
}