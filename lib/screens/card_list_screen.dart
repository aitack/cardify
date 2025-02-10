import 'package:flutter/material.dart';
import '../models/business_card.dart';
import 'business_card_preview_screen.dart';

class CardListScreen extends StatefulWidget {
  const CardListScreen({super.key}); // super.key 形式で修正

  @override
  CardListScreenState createState() => CardListScreenState();
}

class CardListScreenState extends State<CardListScreen> {
  final List<BusinessCard> _cards = [];

  void _addCard(BusinessCard card) {
    int newCardNumber = _cards.isEmpty ? 1 : _cards.last.number + 1;
    setState(() {
      _cards.add(BusinessCard(
        nickname: card.nickname,
        snsUsername: card.snsUsername,
        githubUsername: card.githubUsername,
        noteUsername: card.noteUsername,
        email: card.email,
        other: card.other,
        number: newCardNumber,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Business Card List'),
        backgroundColor: Color(0xFF9C41A0),
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: _cards.length,
          itemBuilder: (context, index) {
            final card = _cards[index];

            return Padding(
              padding: const EdgeInsets.all(16.0), // カード間に余白を追加
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          BusinessCardPreviewScreen(card: card),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white, // カードの背景色
                    borderRadius: BorderRadius.circular(16), // 角丸
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.6), // 薄い影
                        blurRadius: 10, // 影のぼかし
                        offset: Offset(0, 4), // 影の位置
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0), // 内側の余白
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              card.nickname,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 16,
                        right: 16,
                        child: Text(
                          '#${card.number}',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: Container(
        width: 140,
        height: 60,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFF4C7E), Color(0xFF9C41A0)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(50)),
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
          child: Icon(Icons.add, color: Colors.white, size: 50),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
