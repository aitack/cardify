import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // リンクを開くためのパッケージ
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // アイコンパッケージ
import 'package:qr_flutter/qr_flutter.dart';
import '../models/business_card.dart';

class BusinessCardPreviewScreen extends StatelessWidget {
  final BusinessCard card;

  // 修正された部分：key を super.key に渡す
  const BusinessCardPreviewScreen({super.key, required this.card});

  // URLを開くためのヘルパーメソッド
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Business Card Preview')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.6),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 16,
                  left: 16,
                  child: Text(
                    'Card #${card.number}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(0, 0, 0, 0.6),
                    ),
                  ),
                ),
                // QRコードの表示
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: QrImageView(
                    data:
                        'Nickname: ${card.nickname}\nSNS: ${card.snsUsername}\nGithub: ${card.githubUsername}\nNote: ${card.noteUsername}\nEmail: ${card.email}\nOther: ${card.other}',
                    version: QrVersions.auto,
                    size: 120, // サイズを少し大きめに調整
                    errorCorrectionLevel: QrErrorCorrectLevel.H,
                    eyeStyle: QrEyeStyle(
                      eyeShape: QrEyeShape.circle,
                      color: Color(0xFFFB9DA9), // ブランドカラー
                    ),
                    dataModuleStyle: QrDataModuleStyle(
                      dataModuleShape: QrDataModuleShape.circle,
                      color: Color(0xFFFB9DA9), // ブランドカラー
                    ),
                  ),
                ),
                // リンク表示
                Positioned(
                  bottom: 16,
                  left: 20, // 左側に寄せた位置
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        card.nickname,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 12), // リンク群と最初のテキスト間隔調整
                      Row(
                        children: [
                          Icon(FontAwesomeIcons.instagram,
                              size: 18, color: Color(0xFFFB9DA9)), // ブランドカラー
                          SizedBox(width: 8),
                          GestureDetector(
                            onTap: () => _launchURL(
                                'https://www.instagram.com/${card.snsUsername}'),
                            child: Text(
                              '@${card.snsUsername}',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFFFB9DA9)), // ブランドカラー
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4), // 各リンク間隔調整
                      Row(
                        children: [
                          Icon(FontAwesomeIcons.github,
                              size: 18, color: Color(0xFFFB9DA9)), // ブランドカラー
                          SizedBox(width: 8),
                          GestureDetector(
                            onTap: () => _launchURL(
                                'https://github.com/${card.githubUsername}'),
                            child: Text(
                              '@${card.githubUsername}',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFFFB9DA9)), // ブランドカラー
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(FontAwesomeIcons.noteSticky,
                              size: 18, color: Color(0xFFFB9DA9)), // ブランドカラー
                          SizedBox(width: 8),
                          GestureDetector(
                            onTap: () => _launchURL(
                                'https://note.com/${card.noteUsername}'),
                            child: Text(
                              '@${card.noteUsername}',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFFFB9DA9)), // ブランドカラー
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(FontAwesomeIcons.envelope,
                              size: 18, color: Color(0xFFFB9DA9)), // ブランドカラー
                          SizedBox(width: 8),
                          GestureDetector(
                            onTap: () => _launchURL('mailto:${card.email}'),
                            child: Text(
                              card.email,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFFFB9DA9)), // ブランドカラー
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(FontAwesomeIcons.noteSticky,
                              size: 18, color: Color(0xFFFB9DA9)), // ブランドカラー
                          SizedBox(width: 8),
                          GestureDetector(
                            onTap: () =>
                                _launchURL('https://www.${card.other}.com'),
                            child: Text(
                              card.other,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFFFB9DA9)), // ブランドカラー
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
