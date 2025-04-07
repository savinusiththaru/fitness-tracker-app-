import 'package:flutter/material.dart';
import 'workout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'services/auth_services.dart';
import 'components/bottom_navigation.dart';

void main() {
  runApp(const MyApp());
}

// Main application widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitness App',
      theme: ThemeData(
        fontFamily: 'Arial',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFB19589)),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

// Sample data for workout cards
final List<Map<String, String>> workoutCards = [
  {
    'title': 'Body Building',
    'subtitle': 'Full Body Workout',
    'duration': '45 Mins',
    'calories': '200 cal',
    'image': 'assets/pics/workout2.png',
  },
  {
    'title': 'Six Pack',
    'subtitle': 'Upper Body Focused',
    'duration': '40 Mins',
    'calories': '200 cal',
    'image': 'assets/pics/workout1.png',
  },
];

// Widget for individual workout cards
class WorkoutCard extends StatelessWidget {
  final Map<String, String> workout;

  const WorkoutCard({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 239,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                child: Image.asset(
                  workout['image']!,
                  height: 142,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 25,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WorkoutScreen(workout: workout),
                      ),
                    );
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 3.9,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.play_arrow_rounded,
                      size: 30,
                      color: Color.fromARGB(255, 255, 17, 0),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 6),
                Text(
                  workout['title']!,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  workout['subtitle']!,
                  style: const TextStyle(
                    color: Color(0xFF909090),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _buildBadge(
                      icon: Icons.access_time,
                      text: workout['duration']!,
                      color: const Color(0xFF50FF00),
                      backgroundColor: const Color(0xFFE3FFDD),
                    ),
                    const SizedBox(width: 10),
                    _buildBadge(
                      icon: Icons.local_fire_department,
                      text: workout['calories']!,
                      color: const Color(0xFFFEC356),
                      backgroundColor: const Color(0xFFFBE7C2),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge({
    required IconData icon,
    required String text,
    required Color color,
    required Color backgroundColor,
  }) {
    return Container(
      height: 30,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: backgroundColor.withOpacity(0.5),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 4),
          Text(text, style: TextStyle(color: color, fontSize: 12)),
        ],
      ),
    );
  }
}

// Home page widget
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      backgroundColor: const Color(0xFFFFEEE8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // Header section
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
                                color: Color(0xFFB19589),
                              ),
                            )
                            : RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.black,
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
                        const Text(
                          'Good Morning!',
                          style: TextStyle(
                            color: Color(0xFF909090),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const Icon(Icons.notifications_outlined),
                  ],
                ),

                const SizedBox(height: 20),

                // My Plan Card
                Container(
                  height: 184,
                  decoration: BoxDecoration(
                    color: const Color(0xFFB19589),
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 3.5,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 19,
                        left: 25,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'My Plan\nFor The Day',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 29,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              '2/5 Completed',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 15,
                        top: 24,
                        child: SizedBox(
                          width: 150,
                          height: 110,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: 93,
                                height: 93,
                                child: CircularProgressIndicator(
                                  value: 0.2,
                                  backgroundColor: const Color(
                                    0xFFFFEDE5,
                                  ).withOpacity(0.66),
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                        Color.fromARGB(255, 235, 24, 8),
                                      ),
                                  strokeWidth: 16,
                                  strokeCap: StrokeCap.round,
                                ),
                              ),
                              const Text(
                                '20%',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Start New Goal section
                const Text(
                  'Start New Goal',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),

                const SizedBox(height: 20),

                // Workout cards
                SizedBox(
                  height: 252,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: workoutCards.length,
                    itemBuilder:
                        (context, index) => Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: WorkoutCard(workout: workoutCards[index]),
                        ),
                  ),
                ),

                const SizedBox(height: 20),

                // New Meal plans section
                const Text(
                  'New Meal plans',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),

                const SizedBox(height: 20),

                // Meal plan cards
                SizedBox(
                  height: 252,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: workoutCards.length,
                    itemBuilder:
                        (context, index) => Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: WorkoutCard(workout: workoutCards[index]),
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      // Bottom Navigation Bar with Navigation
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }
}
