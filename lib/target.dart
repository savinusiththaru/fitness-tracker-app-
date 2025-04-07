import 'package:flutter/material.dart';
import 'age.dart';
import 'homepage.dart';

// Main entry point of the application
void main() {
  runApp(const MyApp());
}

// Root application widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness Goals',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFB09489)),
        useMaterial3: true,
      ),
      home: const TargetScreen(),
    );
  }
}

// Stateful widget for the target selection screen
class TargetScreen extends StatefulWidget {
  const TargetScreen({super.key});

  @override
  State<TargetScreen> createState() => _TargetScreenState();
}

class _TargetScreenState extends State<TargetScreen> {
  // List of fitness goals
  final List<Goal> goals = [
    Goal(id: 1, title: "Daily Exercises", description: "Burn Calories and Burn fat", icon: "assets/pics/goal1.png"),
    Goal(id: 2, title: "To Get Fit", description: "Find Balance and habits", icon: "assets/pics/goal2.png"),
    Goal(id: 3, title: "Get Strong", description: "Gain muscles and strength", icon: "assets/pics/goal3.png"),
    Goal(id: 4, title: "Mix", description: "Burn Calories and Gain Muscles", icon: "assets/pics/goal4.png"),
  ];

  // Toggle the selection state of a goal
  void toggleGoal(int id) {
    setState(() {
      final index = goals.indexWhere((goal) => goal.id == id);
      if (index != -1) {
        goals[index].selected = !goals[index].selected;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFEEE8),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              // Header
              const Text(
                'Target',
                style: TextStyle(fontSize: 24, fontFamily: 'Poppins'),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              const Text(
                'Select Your Goal!',
                style: TextStyle(fontSize: 27, fontFamily: 'Poppins'),
              ),
              const SizedBox(height: 16),
              const Text(
                'More than one can be selected\n(you can change it later)',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Poppins',
                  color: Color(0xFF909090),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),

              // Goal list
              Expanded(
                child: ListView.builder(
                  itemCount: goals.length,
                  itemBuilder: (context, index) {
                    final goal = goals[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: GoalCard(goal: goal, onTap: () => toggleGoal(goal.id)),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),

              // Navigation buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AgeScreen()), // Navigate to previous screen
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      fixedSize: const Size(168, 62),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      side: const BorderSide(color: Color(0x80909090)),
                    ),
                    child: const Text(
                      'Previous',
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Poppins',
                        color: Color(0xFFB09489),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const HomePage()), // Navigate to next screen
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(166, 62),
                      backgroundColor: const Color(0xFFB09489),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Poppins',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget for displaying individual goal cards
class GoalCard extends StatelessWidget {
  final Goal goal;
  final VoidCallback onTap;

  const GoalCard({super.key, required this.goal, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 77,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                // Goal icon
                Container(
                  width: 70,
                  height: 70,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Image.asset(
                      goal.icon,
                      width: 44,
                      height: 44,
                    ),
                  ),
                ),
                const SizedBox(width: 32),

                // Goal details
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        goal.title,
                        style: const TextStyle(fontFamily: 'Poppins', fontSize: 15),
                      ),
                      Text(
                        goal.description,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                          color: Color(0xFF909090),
                        ),
                      ),
                    ],
                  ),
                ),

                // Selection indicator
                GestureDetector(
                  onTap: onTap,
                  child: Container(
                    width: 20,
                    height: 20,
                    margin: const EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                      color: goal.selected ? const Color(0xFFB09489) : Colors.transparent,
                      border: Border.all(
                        color: const Color(0xFFB09489),
                        width: goal.selected ? 0 : 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: goal.selected
                        ? Image.asset(
                            'assets/icons/tick.png',
                            width: 15,
                            height: 15,
                          )
                        : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Data model for a fitness goal
class Goal {
  final int id;
  final String title;
  final String description;
  final String icon;
  bool selected;

  Goal({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    this.selected = false,
  });
}

// Placeholder for the next screen
class NextScreen extends StatelessWidget {
  const NextScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Next Screen'),
      ),
    );
  }
}