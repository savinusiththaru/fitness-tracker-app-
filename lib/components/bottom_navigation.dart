import 'package:flutter/material.dart';
import '../homepage.dart';
import '../static.dart';
import '../exercise.dart';
import '../health.dart';
import '../profile.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  const BottomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(context, Icons.home_outlined, 0, const HomePage()),
          _buildNavItem(context, Icons.bar_chart, 1, const ProgressScreen()),
          _buildNavItem(context, Icons.fitness_center, 2, const ExercisePage()),
          _buildNavItem(
            context,
            Icons.favorite_border,
            3,
            const HealthScreen(),
          ),
          _buildNavItem(context, Icons.person_outline, 4, ProfileScreen1()),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    IconData icon,
    int index,
    Widget page,
  ) {
    final bool isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        }
      },
      child:
          isSelected
              ? Stack(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Color(0xFFB09489),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: Colors.white),
                  ),
                ],
              )
              : Icon(icon, color: Colors.grey),
    );
  }
}
