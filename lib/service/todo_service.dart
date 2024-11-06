import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logger/logger.dart';

class TodoService {
  final Logger _logger = Logger();  // Logger 인스턴스 생성

  Future<bool> createTodo({
    required int userId,
    required String title,
    required String description,
    required String type,
    required String priority,
    required DateTime date,
  }) async {
    try {
      // DateTime을 UTC로 변환
      String formattedDate = _formatDate(date.toUtc());  // UTC로 변환

      // 서버로 POST 요청 보내기
      final response = await http.post(
        Uri.parse('http://localhost:8080/todo/create'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'userId': userId,
          'title': title,
          'description': description,
          'type': type,  // "TASK" 또는 "NOTE"
          'priority': priority,  // "HIGH", "MEDIUM", "LOW", "NONE"
          'date': formattedDate,  // 밀리초를 제외한 날짜
        }),
      );

      // 로그: 응답 상태와 본문 출력
      _logger.i('Response status: ${response.statusCode}');
      _logger.i('Response body: ${response.body}');

      // 응답 상태에 따라 성공/실패 처리
      if (response.statusCode == 200) {
        _logger.i('Todo created successfully');
        return true;
      } else {
        // 상태 코드가 200이 아니면 실패로 간주하고 원인 출력
        _logger.w('Failed to create Todo. Status code: ${response.statusCode}');
        _logger.w('Response body: ${response.body}');
        return false;
      }
    } catch (e) {
      // 예외 발생 시 에러 로그 출력
      _logger.e('Error while creating Todo: $e');
      return false;
    }
  }

  // 밀리초를 제외한 날짜 포맷팅 함수
  String _formatDate(DateTime date) {
    // 밀리초를 제외하고 "yyyy-MM-dd'T'HH:mm:ss" 형식으로 변환
    return '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}T${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}:${date.second.toString().padLeft(2, '0')}Z'; // 'Z'는 UTC를 나타냄
  }
}