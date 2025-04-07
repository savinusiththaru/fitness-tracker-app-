import 'package:flutter/material.dart';
import 'dart:async';
import 'workout6.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workout App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WorkoutScreen1(),
    );
  }
}

class WorkoutScreen1 extends StatefulWidget {
  const WorkoutScreen1({super.key});

  @override
  State<WorkoutScreen1> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen1> {
  Duration _duration = const Duration(minutes: 5);
  late Timer _timer;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _isRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_duration.inSeconds > 0) {
          _duration = _duration - const Duration(seconds: 1);
        } else {
          _timer.cancel();
          _isRunning = false;
        }
      });
    });
  }

  void _pauseTimer() {
    _timer.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  void _resetTimer() {
    _timer.cancel();
    setState(() {
      _duration = const Duration(minutes: 5);
      _isRunning = false;
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Task'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Exercise header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Exercise',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Set 01 <02/10>',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const Divider(height: 20, thickness: 1),
            
            // Exercise name and duration
            const Text(
              'Jumping Jack',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  _formatDuration(_duration),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 16),
                IconButton(
                  icon: Icon(_isRunning ? Icons.pause : Icons.play_arrow),
                  onPressed: () {
                    if (_isRunning) {
                      _pauseTimer();
                    } else {
                      _startTimer();
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.replay),
                  onPressed: _resetTimer,
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Description
            const Text(
              'A jumping jack, also known as a star jump and called a side-straddle hop in the US military, '
              'is a physical jumping exercise performed by jumping to a position with the legs spread wide '
              'Read More...',
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            
            // How to do it section
            const Text(
              'How To Do It',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '4 Steps',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            
            // Steps
            _buildStep(
              number: '01',
              isActive: true,
              title: 'Spread Your Arms',
              description: 'To make the gestures feel more relaxed, stretch your arms as you start this movement. No bending of hands.',
            ),
            _buildStep(
              number: '02',
              isActive: true,
              title: 'Rest at The Toe',
              description: 'The basis of this movement is jumping. Now, what needs to be considered is that you have to use the tips of your feet.',
            ),
            _buildStep(
              number: '03',
              isActive: true,
              title: 'Adjust Foot Movement',
              description: 'Jumping Jack is not just an ordinary jump. But, you also have to pay close attention to leg movements.',
            ),
            _buildStep(
              number: '04',
              isActive: true,
              title: 'Clapping Both Hands',
              description: 'This cannot be taken lightly. You see, without realizing it, the clapping of your hands helps you to keep your rhythm while doing the Jumping Jack.',
            ),
            
            const Divider(height: 40, thickness: 1),
            
            // Custom repetitions
            _buildCustomRepetition('450 Calories Bum', '29'),
            const SizedBox(height: 16),
            _buildCustomRepetition('450 Calories Bum', '30 times'),
            
            const SizedBox(height: 30),
            
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TaskCompletedScreen()), // Replace with your target page
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Column(
                  children: [
                    const Text(
                      'Next>>',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black, // You can adjust the color
                        fontWeight: FontWeight.bold, // Optional: make it stand out
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep({
    required String number,
    required bool isActive,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: isActive ? Colors.orange : Colors.grey[300],
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: TextStyle(
                  color: isActive ? Colors.white : Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isActive ? Colors.black : Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          if (isActive) const Icon(Icons.local_fire_department, color: Colors.orange),
        ],
      ),
    );
  }

  Widget _buildCustomRepetition(String title, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}