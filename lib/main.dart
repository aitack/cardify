import 'package:flutter/material.dart';
import 'screens/card_list_screen.dart'; // カード一覧画面
import 'screens/create_card_screen.dart'; // 名刺作成画面

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
      initialRoute: '/', // 最初に表示する画面（カード一覧）
      routes: {
        '/': (context) => CardListScreen(), // カード一覧画面
        '/create-card': (context) => CreateCardScreen(), // カード作成画面
      },
    );
  }
}
