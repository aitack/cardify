import 'package:flutter/material.dart';
import 'screens/card_list_screen.dart';
import 'screens/create_card_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // ここを修正

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Digital Business Card',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => CardListScreen(),
        '/create-card': (context) => CreateCardScreen(),
      },
    );
  }
}
