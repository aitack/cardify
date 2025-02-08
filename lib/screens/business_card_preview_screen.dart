import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:gallery_saver/gallery_saver.dart';
import '../models/business_card.dart';
import 'business_card_qr_code_screen.dart'; // QRコード画面

class BusinessCardPreviewScreen extends StatefulWidget {
  final BusinessCard card;

  BusinessCardPreviewScreen({required this.card});

  @override
  _BusinessCardPreviewScreenState createState() =>
      _BusinessCardPreviewScreenState();
}

class _BusinessCardPreviewScreenState extends State<BusinessCardPreviewScreen> {
  ScreenshotController _screenshotController = ScreenshotController();

  // 画像として保存する処理
  Future<void> _saveAsImage(BuildContext context) async {
    try {
      // スクリーンショットをキャプチャ
      final image = await _screenshotController.captureFromWidget(
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                widget.card.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(widget.card.jobTitle),
              Text(widget.card.email),
              Text(widget.card.phone),
              SizedBox(height: 20),
            ],
          ),
        ),
      );

      if (image == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('画像のキャプチャに失敗しました')),
        );
        return;
      }

      // 保存先のディレクトリを取得
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/business_card.png';
      final file = File(filePath);
      await file.writeAsBytes(image);

      // ギャラリーに保存
      await GallerySaver.saveImage(filePath);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('名刺を画像として保存しました！')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('保存に失敗しました: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Business Card Preview')),
      body: Screenshot(
        controller: _screenshotController, // ScreenshotControllerを設定
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                widget.card.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(widget.card.jobTitle),
              Text(widget.card.email),
              Text(widget.card.phone),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // 名刺情報を QR コードのデータに変換
                  String qrData = 'Name: ${widget.card.name}\n'
                      'Job Title: ${widget.card.jobTitle}\n'
                      'Email: ${widget.card.email}\n'
                      'Phone: ${widget.card.phone}';

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
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _saveAsImage(context), // 画像として保存
                child: Text('Save as Image'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
