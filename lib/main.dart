import 'package:flutter/material.dart';
import 'screens/create_card_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Digital Business Card',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CreateCardScreen(), // 最初に表示する画面
    );
  }
}
