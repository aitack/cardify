import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class BusinessCardQRCodeScreen extends StatelessWidget {
  final String qrData; // 必須の引数としてqrDataを受け取る

  // コンストラクタでqrDataを受け取る
  BusinessCardQRCodeScreen({required this.qrData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Business Card QR Code'),
      ),
      body: Center(
        child: QrImageView(
          data: qrData, // QRコードに埋め込むデータ
          version: QrVersions.auto, // QRコードのバージョンを自動設定
          size: 300.0, // QRコードのサイズ
        ),
      ),
    );
  }
}
