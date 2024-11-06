import 'package:bj/modal/add_todo_modal.dart';
import 'package:bj/service/todo_service.dart';

import 'package:flutter/material.dart';

import 'mandalart_screen.dart';
import 'habit_tracker_screen.dart';
import 'mood_tracker_screen.dart';
import 'one_line_diary_screen.dart';
import 'day_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    const DayScreen(),
    const MandalartScreen(),
    const HabitTrackerScreen(),
    const MoodTrackerScreen(),
    const OneLineDiaryScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

 void _showAddTodoModal() {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return AddTodoModal(
        onAdd: (title, description, type, date, priority) async {
          TodoService todoService = TodoService();

          // userId 값을 추가하여 서버로 데이터 전송
          final userId = 1; // 로그인한 사용자 ID 또는 필요한 값으로 변경

          bool success = await todoService.createTodo(
            userId: userId, // userId 추가
            title: title,
            description: description,
            type: type.toString(),
            priority: priority.toString(),
            date: date,
          );

          if (success) {
            print('Todo created successfully');
          } else {
            print('Failed to create Todo');
          }
        },
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
          Expanded(
            child: Center(
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  '2024년 11월 4일',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddTodoModal, // 모달 창 표시 함수 호출
          ),
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.today),
            label: 'Day',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: 'Mandalart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: 'Habit Tracker',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sentiment_satisfied),
            label: 'Mood Tracker',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note),
            label: 'One Line Diary',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}