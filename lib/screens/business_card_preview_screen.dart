import 'package:flutter/material.dart';
import '../models/business_card.dart';
import 'business_card_qr_code_screen.dart'; // QRコード画面

class BusinessCardPreviewScreen extends StatelessWidget {
  final BusinessCard card;

  BusinessCardPreviewScreen({required this.card});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Business Card Preview')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(card.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(card.jobTitle),
            Text(card.email),
            Text(card.phone),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // card から QR コード用の文字列を作成
                String qrData = 'Name: ${card.name}\n'
                    'Job Title: ${card.jobTitle}\n'
                    'Email: ${card.email}\n'
                    'Phone: ${card.phone}';

                // QRコード画面へ遷移
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        BusinessCardQRCodeScreen(qrData: qrData),
                  ),
                );
              },
              child: Text('Share QR Code'),
            ),
          ],
        ),
      ),
    );
  }
}
