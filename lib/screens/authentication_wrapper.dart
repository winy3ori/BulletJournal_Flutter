import 'package:flutter/material.dart';
import 'main.dart'; // 새로운 파일로 이동


class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = true; // 로그인 상태 확인

    if (isLoggedIn) {
      return const MainScreen();
    }
  }
}