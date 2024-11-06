import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeZoneExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 현재 UTC 시간
    DateTime utcNow = DateTime.now().toUtc();

    // 6시간 더하기
    DateTime localTime = utcNow.add(Duration(hours: 6));

    // 포맷 지정
    String formattedTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(localTime);

    return Scaffold(
      appBar: AppBar(title: Text('6시간 차이 설정')),
      body: Center(
        child: Text(
          '6시간 차이 시간: $formattedTime',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}