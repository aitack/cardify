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
    // カード番号をリスト内の最終番号から次の番号を設定
    int newCardNumber = _cards.isEmpty ? 1 : _cards.last.number + 1;

    // 新しいカードをリストに追加
    setState(() {
      _cards.add(BusinessCard(
        name: card.name,
        jobTitle: card.jobTitle,
        email: card.email,
        phone: card.phone,
        number: newCardNumber, // 自動でナンバーを設定
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Business Card List'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // 新しいカード作成画面に遷移
              Navigator.pushNamed(context, '/create-card').then((newCard) {
                if (newCard != null) {
                  _addCard(newCard as BusinessCard); // 新しいカードを追加
                }
              });
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _cards.length,
        itemBuilder: (context, index) {
          final card = _cards[index];
          return ListTile(
            title: Text(card.name),
            subtitle: Text(card.jobTitle),
            trailing: Text('#${card.number}'), // カードの番号を表示
            onTap: () {
              // プレビュー画面に遷移
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
    );
  }
}
