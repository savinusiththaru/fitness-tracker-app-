import 'package:flutter/material.dart';
import 'components/bottom_navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'services/auth_services.dart';

// Main Application Entry Point
void main() {
  runApp(const MyApp());
}

// App Configuration
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercise App',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: Colors.blue[600],
        fontFamily: 'Poppins',
      ),
      home: const ExercisePage(),
    );
  }
}

// Main Exercise Page
class ExercisePage extends StatefulWidget {
  const ExercisePage({super.key});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  final AuthService _authService = AuthService();
  String _userName = 'User';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      Map<String, dynamic>? userData = await _authService.getUserData();

      if (userData != null && userData.containsKey('fullName')) {
        setState(() {
          _userName = userData['fullName'];
        });
      } else {
        // If no Firestore data, try to get display name from Firebase Auth
        User? user = _authService.currentUser;
        if (user != null &&
            user.displayName != null &&
            user.displayName!.isNotEmpty) {
          setState(() {
            _userName = user.displayName!;
          });
        }
      }
    } catch (e) {
      print('Error loading user data: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 239, 232),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                // Header Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _isLoading
                            ? const SizedBox(
                              width: 150,
                              child: LinearProgressIndicator(
                                backgroundColor: Color(0xFFFFEEE8),
                                color: Color(0xFFB09489),
                              ),
                            )
                            : RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                ),
                                children: [
                                  const TextSpan(text: 'Hello '),
                                  TextSpan(
                                    text: _userName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        const SizedBox(height: 4),
                        RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontFamily: 'Poppins',
                            ),
                            children: [
                              TextSpan(text: 'You are on a '),
                              TextSpan(
                                text: '3 day',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 181, 67, 19),
                                ),
                              ),
                              TextSpan(text: ' Streak! Keep it up!'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Icon(Icons.notifications_outlined, size: 23),
                  ],
                ),
                const SizedBox(height: 24),
                // Workout Cards Section
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildWorkoutCard(
                        title: 'Cardio',
                        duration: '20 mins',
                        exercises: 3,
                        imagePaths: [
                          'assets/pics/cardio1.png',
                          'assets/pics/cardio2.png',
                          'assets/pics/cardio3.png',
                        ],
                      ),
                      const SizedBox(width: 16),
                      _buildWorkoutCard(
                        title: 'Warm Up',
                        duration: '15 mins',
                        exercises: 3,
                        imagePaths: [
                          'assets/pics/cardio4.png',
                          'assets/pics/cardio5.png',
                          'assets/pics/cardio6.png',
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Daily Progress Section
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDDCDC7),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Daily Progress',
                        style: TextStyle(fontSize: 15, fontFamily: 'Poppins'),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          _buildCaloriesCard(),
                          const SizedBox(width: 12),
                          Column(
                            children: [
                              _buildMetricCard(
                                icon: Icons.access_time,
                                title: 'Time',
                                value: '2Hours 10mins',
                                color: const Color(0xFF2C2645),
                              ),
                              const SizedBox(height: 18),
                              _buildMetricCard(
                                icon: Icons.flag_outlined,
                                title: 'Goal',
                                value: '1000kcal',
                                color: const Color(0xFF2F4526),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Browse By Area Section
                const Text(
                  'Browse By Area',
                  style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
                ),
                const SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildAreaChip('Arms', true),
                      _buildAreaChip('Shoulders', false),
                      _buildAreaChip('Back', false),
                      _buildAreaChip('Chest', false),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                // Workout Images Section
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _buildWorkoutImageCard(
                              'Bicep workouts',
                              'assets/pics/bicep.png',
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildWorkoutImageCard(
                              'Tricep workouts',
                              'assets/pics/tricep.png',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildWorkoutImageCard(
                        'Forearm workouts',
                        'assets/pics/forearm.png',
                        fullWidth: true,
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
      bottomNavigationBar: const BottomNavBar(currentIndex: 2),
    );
  }

  // Helper Widgets
  Widget _buildWorkoutCard({
    required String title,
    required String duration,
    required int exercises,
    required List<String> imagePaths,
  }) {
    return Container(
      width: 242,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 3.7,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontFamily: 'Poppins'),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.access_time, size: 15),
              const SizedBox(width: 4),
              Text(
                duration,
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFFB09489),
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.fitness_center, size: 15),
              const SizedBox(width: 4),
              Text(
                '$exercises Exercises',
                style: const TextStyle(
                  fontSize: 11,
                  color: Color.fromARGB(255, 23, 8, 2),
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                width: 53,
                height: 53,
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(imagePaths[0]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: 53,
                height: 53,
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(imagePaths[1]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: 53,
                height: 53,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(imagePaths[2]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCaloriesCard() {
    return Container(
      width: 165,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFE1600),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.local_fire_department,
                  color: Colors.white,
                  size: 16,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Calories',
                style: TextStyle(fontSize: 15, fontFamily: 'Poppins'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 110,
                height: 75,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: CircularProgressIndicator(
                        value: 0.75,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Color.fromARGB(255, 235, 24, 8),
                        ),
                        strokeWidth: 20,
                        strokeCap: StrokeCap.round,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                '1069 kcal',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 0),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      width: 146,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: Colors.white, size: 16),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(fontSize: 15, fontFamily: 'Poppins'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              value,
              style: const TextStyle(fontSize: 14, fontFamily: 'Poppins'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAreaChip(String label, bool isActive) {
    return Container(
      margin: const EdgeInsets.only(right: 26),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
      decoration: BoxDecoration(
        color: isActive ? Colors.white : const Color(0xFFDDCDC7),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.black,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }

  Widget _buildWorkoutImageCard(
    String title,
    String imagePath, {
    bool fullWidth = false,
  }) {
    return Container(
      height: fullWidth ? 139 : 154,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 8,
            left: 0,
            right: 0,
            child: Text(
              '$title >',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ],
      ),
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
