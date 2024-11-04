import 'package:flutter/material.dart';

class HabitTrackerScreen extends StatelessWidget {
  const HabitTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Habit Tracker View', // 수정된 텍스트
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}