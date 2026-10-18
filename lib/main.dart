
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'profile_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LocalFix',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF008C8C),
        ),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
      routes: {
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}
