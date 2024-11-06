import 'package:bj/enum/todo_Priority.dart';
import 'package:bj/enum/todo_Type.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // 날짜 포맷을 위해 사용

class AddTodoModal extends StatefulWidget {
  final Function(String, String, TodoType, DateTime, TodoPriority) onAdd;

  const AddTodoModal({super.key, required this.onAdd});

  @override
  _AddTodoModalState createState() => _AddTodoModalState();
}

class _AddTodoModalState extends State<AddTodoModal> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  TodoType _selectedType = TodoType.task;
  DateTime _selectedDate = DateTime.now().toUtc(); // UTC로 초기화
  TodoPriority _selectedPriority = TodoPriority.none;

  void _submit() {
    final title = _titleController.text;
    final description = _descriptionController.text;

    if (title.isNotEmpty) {
      // 서버로 전송할 때 UTC 시간으로 변환하여 전달
      widget.onAdd(title, description, _selectedType, _selectedDate, _selectedPriority);
      Navigator.pop(context); // 모달 닫기
    }
  }

  @override
  Widget build(BuildContext context) {
    // 날짜 및 시간 포맷팅
    String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);
    String formattedTime = DateFormat('HH:mm').format(_selectedDate);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '새 할 일 추가',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: '할 일 제목',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: '할 일 내용',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButton<TodoType>(
              value: _selectedType,
              items: TodoType.values.map((TodoType type) {
                return DropdownMenuItem<TodoType>(
                  value: type,
                  child: Text(type.toString().split('.').last), // enum 이름 표시
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedType = value!;
                });
              },
              hint: const Text("할 일 타입 선택"),
            ),
            const SizedBox(height: 16),
            DropdownButton<TodoPriority>(
              value: _selectedPriority,
              items: TodoPriority.values.map((TodoPriority priority) {
                return DropdownMenuItem<TodoPriority>(
                  value: priority,
                  child: Text(priority.toString().split('.').last), // enum 이름 표시
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedPriority = value!;
                });
              },
              hint: const Text("우선 순위 선택"),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () async {
                final DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null && pickedDate != _selectedDate) {
                  setState(() {
                    _selectedDate = pickedDate.toUtc(); // 선택된 날짜를 UTC로 변환
                  });
                }
              },
              child: Text("날짜 선택: $formattedDate"), // 선택된 날짜 표시
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () async {
                final TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.fromDateTime(_selectedDate),
                );
                if (pickedTime != null) {
                  setState(() {
                    // TimeOfDay -> DateTime 변환 후 UTC로 변환
                    _selectedDate = DateTime(
                      _selectedDate.year,
                      _selectedDate.month,
                      _selectedDate.day,
                      pickedTime.hour,
                      pickedTime.minute,
                    ).toUtc(); // 선택된 시간도 UTC로 변환
                  });
                }
              },
              child: Text("시간 선택: $formattedTime"), // 선택된 시간 표시
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('저장'),
            ),
          ],
        ),
      ),
    );
  }
}
