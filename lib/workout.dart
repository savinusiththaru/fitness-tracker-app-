import 'package:flutter/material.dart';
import 'workout3.dart';

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
      title: 'Workout App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: 'Poppins',
      ),
      home: const WorkoutScreen(workout: {},),
    );
  }
}

// Main Workout Screen
class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key, required Map<String, String> workout});

  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  String _selectedLevel = 'Beginner'; // Track the selected level

  // Method to show the level selection dialog
  void _showLevelSelectionDialog(BuildContext context) {
    String tempSelectedLevel = _selectedLevel; // Temporary state for dialog

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setDialogState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title
                    const Text(
                      'Select Level',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Divider
                    Container(
                      width: 40,
                      height: 2,
                      color: Colors.black,
                    ),
                    const SizedBox(height: 20),
                    // Beginner Option
                    _buildLevelOption(
                      context,
                      title: 'Beginner',
                      description: 'I can do 3-5 Pushups',
                      isSelected: tempSelectedLevel == 'Beginner',
                      isSelectable: true,
                      onTap: () {
                        setDialogState(() {
                          tempSelectedLevel = 'Beginner';
                        });
                        setState(() {
                          _selectedLevel = 'Beginner';
                        });
                        Navigator.pop(context);
                        _showTimeSelectionDialog(context); // Show the second dialog
                      },
                    ),
                    const SizedBox(height: 10),
                    // Intermediate Option
                    _buildLevelOption(
                      context,
                      title: 'Intermediate',
                      description: 'I can do 8-10 Pushups',
                      isSelected: tempSelectedLevel == 'Intermediate',
                      isSelectable: true,
                      onTap: () {
                        setDialogState(() {
                          tempSelectedLevel = 'Intermediate';
                        });
                        setState(() {
                          _selectedLevel = 'Intermediate';
                        });
                        Navigator.pop(context);
                        _showTimeSelectionDialog(context); // Show the second dialog
                      },
                    ),
                    const SizedBox(height: 10),
                    // Advanced Option
                    _buildLevelOption(
                      context,
                      title: 'Advance',
                      description: 'I can do 10-25 Pushups',
                      isSelected: tempSelectedLevel == 'Advance',
                      isSelectable: true,
                      onTap: () {
                        setDialogState(() {
                          tempSelectedLevel = 'Advance';
                        });
                        setState(() {
                          _selectedLevel = 'Advance';
                        });
                        Navigator.pop(context);
                        _showTimeSelectionDialog(context); // Show the second dialog
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // Method to show the time selection dialog
  void _showTimeSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title
                const Text(
                  'Select Time',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 10),
                // Divider
                Container(
                  width: 40,
                  height: 2,
                  color: Colors.black,
                ),
                const SizedBox(height: 20),
                // Schedule Option
                _buildTimeOption(
                  context,
                  title: 'Schedule',
                  description: 'Schedule The Workout!',
                  isSelected: true, // Default to Schedule as selected
                  onTap: () {
                    Navigator.pop(context);
                    // Add logic for scheduling the workout
                  },
                ),
                const SizedBox(height: 10),
                // Start Now Option
                _buildTimeOption(
                  context,
                  title: 'Start Now',
                  description: 'Start To Work Out Now',
                  isSelected: false,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const WorkoutApp()),
                    );
                  },
                ),  
              ],
            ),
          ),
        );
      },
    );
  }

  // Helper method to build each level option
  Widget _buildLevelOption(
    BuildContext context, {
    required String title,
    required String description,
    required bool isSelected,
    required bool isSelectable,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: isSelectable ? onTap : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFB09489)
              : (isSelectable ? Colors.white : Colors.grey[200]),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelectable ? const Color(0xFFB09489) : Colors.grey,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? Colors.white
                          : (isSelectable ? Colors.black : Colors.grey),
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: isSelected
                          ? Colors.white
                          : (isSelectable ? Colors.black : Colors.grey),
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Helper method to build each time option
  Widget _buildTimeOption(
    BuildContext context, {
    required String title,
    required String description,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFB09489) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xFFB09489),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : Colors.black,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: isSelected ? Colors.white : Colors.black,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final weekData = [
      {
        'week': '01',
        'title': 'WEEK 01',
        'progress': '01/07',
        'days': [
          {'number': 1, 'active': true},
          {'number': 2, 'active': false},
          {'number': 3, 'active': false},
          {'number': 4, 'active': false},
          {'number': 5, 'active': false},
          {'number': 6, 'active': false},
          {'number': 7, 'active': false},
          {'number': 8, 'active': false, 'image': 'assets/pics/bullseye.png'},
        ],
      },
      {
        'week': '02',
        'title': 'WEEK 02',
        'progress': '00/07',
        'days': [
          {'number': 1, 'active': false},
          {'number': 2, 'active': false},
          {'number': 3, 'active': false},
          {'number': 4, 'active': false},
          {'number': 5, 'active': false},
          {'number': 6, 'active': false},
          {'number': 7, 'active': false},
          {'number': 8, 'active': false, 'image': 'assets/pics/bullseye.png'},
        ],
      },
    ];

    return Scaffold(
      body: Container(
        color: const Color(0xFFFFEEE8),
        child: Stack(
          children: [
            // Background Image (Moved down to leave space for notification bar)
            Positioned(
              top: 50,
              left: 0,
              right: 0,
              height: 276,
              child: Image.asset(
                'assets/pics/workout1.png',
                fit: BoxFit.cover,
              ),
            ),

            // Main Content Container (Adjusted position)
            Positioned(
              top: 278,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFFFEDE5),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
              ),
            ),

            // Level and Progress Card
            Positioned(
              top: 239,
              left: 33,
              child: Container(
                width: 325,
                height: 78,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 3.5,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Level Section
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Level',
                              style: TextStyle(
                                color: Color(0xFF909090),
                                fontSize: 14,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFF8900),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '$_selectedLevel>',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Vertical Divider
                    Container(
                      width: 1,
                      height: 46,
                      color: Colors.grey[300],
                    ),
                    // Progress Section
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 24, right: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Progress',
                                  style: TextStyle(
                                    color: Color(0xFF909090),
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  '7%',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ],
                            ),
                            Image.asset(
                              'assets/pics/bullseye.png',
                              width: 22,
                              height: 22,
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Workout Title (Adjusted position)
            Positioned(
              top: 165,
              left: 17,
              child: Row(
                children: [
                  Container(
                    width: 1,
                    height: 56,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 6),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Body Building',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Full Body Workout',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Back Button (Adjusted position)
            Positioned(
              top: 110,
              left: 17,
              child: IconButton(
                icon: const Icon(
                  Icons.chevron_left_outlined,
                  color: Colors.white,
                  size: 32,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),

            // Week Sections (Adjusted position)
            ...weekData.asMap().entries.map((entry) {
              final weekIndex = entry.key;
              final week = entry.value;
              return Positioned(
                top: weekIndex == 0 ? 353 : 633,
                left: 17,
                child: SizedBox(
                  width: 367,
                  height: 251,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            week['title'] as String,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: (week['progress'] as String).split('/')[0],
                                  style: const TextStyle(
                                    color: Color(0xFFFF8900),
                                    fontSize: 16,
                                  ),
                                ),
                                TextSpan(
                                  text: '/${(week['progress'] as String).split('/')[1]}',
                                  style: const TextStyle(
                                    color: Color(0xFF909090),
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // First Row of Days (Days 1-4)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int i = 0; i < 4; i++) ...[
                            // Day circle
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: (week['days'] as List<Map<String, dynamic>>)[i]['active']
                                    ? const Color(0xFFFF8900)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: (week['days'] as List<Map<String, dynamic>>)[i]['active']
                                      ? const Color(0xFFFF8900)
                                      : const Color(0xFFB09489),
                                ),
                              ),
                              child: Center(
                                child: (week['days'] as List<Map<String, dynamic>>)[i].containsKey('image')
                                    ? Image.asset(
                                        (week['days'] as List<Map<String, dynamic>>)[i]['image'] as String,
                                        width: 24,
                                        height: 24,
                                        fit: BoxFit.contain,
                                      )
                                    : Text(
                                        (week['days'] as List<Map<String, dynamic>>)[i]['number'].toString(),
                                        style: TextStyle(
                                          color: (week['days'] as List<Map<String, dynamic>>)[i]['active']
                                              ? Colors.white
                                              : const Color(0xFFB09489),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                              ),
                            ),

                            // Add spacing and arrow after each day except the last one
                            if (i < 3)
                              Row(
                                children: const [
                                  SizedBox(width: 15),
                                  Icon(
                                    Icons.arrow_right_alt,
                                    color: Color(0xFFB09489),
                                    size: 30,
                                  ),
                                  SizedBox(width: 15),
                                ],
                              ),
                          ],
                        ],
                      ),

                      const SizedBox(height: 24), // Increased vertical spacing between rows

                      // Second Row of Days (Days 5-8)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int i = 4; i < (week['days'] as List<Map<String, dynamic>>).length; i++) ...[
                            // Day circle
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: (week['days'] as List<Map<String, dynamic>>)[i]['active']
                                    ? const Color(0xFFFF8900)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: (week['days'] as List<Map<String, dynamic>>)[i]['active']
                                      ? const Color(0xFFFF8900)
                                      : const Color(0xFFB09489),
                                ),
                              ),
                              child: Center(
                                child: (week['days'] as List<Map<String, dynamic>>)[i].containsKey('image')
                                    ? Image.asset(
                                        (week['days'] as List<Map<String, dynamic>>)[i]['image'] as String,
                                        width: 24,
                                        height: 24,
                                        fit: BoxFit.contain,
                                      )
                                    : Text(
                                        (week['days'] as List<Map<String, dynamic>>)[i]['number'].toString(),
                                        style: TextStyle(
                                          color: (week['days'] as List<Map<String, dynamic>>)[i]['active']
                                              ? Colors.white
                                              : const Color(0xFFB09489),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                              ),
                            ),

                            // Add spacing and arrow after each day except the last one
                            if (i < (week['days'] as List<Map<String, dynamic>>).length - 1)
                              Row(
                                children: const [
                                  SizedBox(width: 15),
                                  Icon(
                                    Icons.arrow_right_alt,
                                    color: Color(0xFFB09489),
                                    size: 30,
                                  ),
                                  SizedBox(width: 15),
                                ],
                              ),
                          ],
                        ],
                      ),
                      if (weekIndex == 0)
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 34),
                            child: SizedBox(
                              width: 316,
                              height: 62,
                              child: ElevatedButton(
                                onPressed: () {
                                  _showLevelSelectionDialog(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFB09489).withOpacity(0.5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: const Text(
                                  'Start Workout',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}