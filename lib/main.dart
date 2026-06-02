import 'package:flutter/material.dart';
import 'package:task/pages/home_page.dart';
import 'package:task/pages/on_boarding_page.dart';
import 'package:task/service/storage_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> _checkSubscription() async {
    return await StorageService.isSubscribed();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
        future: _checkSubscription(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }

          return snapshot.data! ? const HomeScreen() : const OnboardingScreen();
        },
      ),
    );
  }
}
