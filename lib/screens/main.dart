import 'package:flutter/material.dart';
import 'mandalart_screen.dart';
import 'habit_tracker_screen.dart';
import 'mood_tracker_screen.dart';
import 'one_line_diary_screen.dart';
import 'day_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // 각 하단바 항목에 해당하는 위젯 목록
  final List<Widget> _widgetOptions = <Widget>[
    const DayScreen(),
    const MandalartScreen(),
    const HabitTrackerScreen(),
    const MoodTrackerScreen(),
    const OneLineDiaryScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // 선택된 인덱스 업데이트
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          // 메뉴 버튼 (왼쪽 끝)
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
          // 날짜 버튼 (가운데)
          Expanded(
            child: Center(
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  '2024년 11월 4일',
                  style: TextStyle(color: Colors.black), // 검정색으로 설정
                ),
              ),
            ),
          ),
          // 추가 버튼 (오른쪽 끝)
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // 추가 버튼 클릭 시 동작
            },
          ),
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex), // 선택된 화면 표시

      
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
        selectedItemColor: Colors.black, // 선택된 항목의 색상
        unselectedItemColor: Colors.grey, // 선택되지 않은 항목의 색상
        onTap: _onItemTapped,
      ),
    );
  }
}