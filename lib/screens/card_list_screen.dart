import 'package:flutter/material.dart';
import '../models/business_card.dart'; // BusinessCardモデルのインポート
import 'business_card_preview_screen.dart'; // 名刺プレビュー画面

class CardListScreen extends StatefulWidget {
  @override
  _CardListScreenState createState() => _CardListScreenState();
}

class _CardListScreenState extends State<CardListScreen> {
  List<BusinessCard> _cards = []; // 名刺カードのリスト

  void _addCard(BusinessCard card) {
    int newCardNumber = _cards.isEmpty ? 1 : _cards.last.number + 1;
    setState(() {
      _cards.add(BusinessCard(
        name: card.name,
        jobTitle: card.jobTitle,
        email: card.email,
        phone: card.phone,
        number: newCardNumber,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Business Card List'),
        backgroundColor: Color(0xFF9C41A0), // 紫
      ),
      body: Container(
        color: Colors.white, // シンプルな白背景
        child: ListView.builder(
          itemCount: _cards.length,
          itemBuilder: (context, index) {
            final card = _cards[index];
            return ListTile(
              title: Text(card.name),
              subtitle: Text(card.jobTitle),
              trailing: Text('#${card.number}'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BusinessCardPreviewScreen(card: card),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [Color(0xFFFF4C7E), Color(0xFF9C41A0)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/create-card').then((newCard) {
              if (newCard != null) {
                _addCard(newCard as BusinessCard);
              }
            });
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Icon(Icons.add, color: Colors.white, size: 32),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
