import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../models/business_card.dart';

class BusinessCardPreviewScreen extends StatelessWidget {
  final BusinessCard card;

  BusinessCardPreviewScreen({required this.card});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Business Card Preview')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            // 名刺風デザインのため縦長にし、角を丸めてシャドウを追加
            width: MediaQuery.of(context).size.width * 0.8, // スマホ画面の80%の幅
            height: MediaQuery.of(context).size.height * 0.6, // スマホ画面の60%の高さ
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 5), // シャドウの位置
                ),
              ],
            ),
            child: Stack(
              children: [
                // 上部にナンバー表示
                Positioned(
                  top: 16, // 上から16ピクセルの位置に配置
                  left: 16, // 左から16ピクセルの位置に配置
                  child: Text(
                    'Card #${card.number}', // カード番号を表示
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                ),
                // QRコードの右下配置
                Positioned(
                  bottom: 16, // 下から16ピクセルの位置に配置
                  right: 16, // 右から16ピクセルの位置に配置
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // QRコードの背景を白に設定
                      borderRadius: BorderRadius.circular(8), // QRコードの角を丸く
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15), // シャドウの色
                          blurRadius: 6, // シャドウのぼかし具合
                          offset: Offset(2, 2), // シャドウの位置
                        ),
                      ],
                    ),
                    child: QrImageView(
                      data:
                          'Name: ${card.name}\nJob Title: ${card.jobTitle}\nEmail: ${card.email}\nPhone: ${card.phone}',
                      version: QrVersions.auto,
                      size: 80, // QRコードのサイズを少し小さく
                      errorCorrectionLevel: QrErrorCorrectLevel.H,
                      eyeStyle: QrEyeStyle(
                        eyeShape: QrEyeShape.circle,
                        color: Color(0xFFFB9DA9), // 目の色
                      ),
                      dataModuleStyle: QrDataModuleStyle(
                        dataModuleShape: QrDataModuleShape.circle,
                        color: Color(0xFFFB9DA9), // データモジュールの色
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 100.0, left: 16.0, right: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(card.name,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      Text(card.jobTitle),
                      Text(card.email),
                      Text(card.phone),
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
