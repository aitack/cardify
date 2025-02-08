import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class BusinessCardQRCodeScreen extends StatelessWidget {
  final String qrData;

  BusinessCardQRCodeScreen({required this.qrData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('QR Code')),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 背景のドット模様
            CustomPaint(
              size: Size(220, 220),
              painter: DotPatternPainter(),
            ),
            // ドットデザインのQRコード
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: QrImageView(
                data: qrData,
                version: QrVersions.auto,
                size: 180,
                errorCorrectionLevel: QrErrorCorrectLevel.H,
                eyeStyle: QrEyeStyle(
                  eyeShape: QrEyeShape.circle, // 目の部分をドットに
                  color: Colors.black,
                ),
                dataModuleStyle: QrDataModuleStyle(
                  dataModuleShape: QrDataModuleShape.circle, // QRのドットを丸に
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 🔵 背景のドット模様（変更なし）
class DotPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.purple.withOpacity(0.3);
    const double spacing = 18; // ドットの間隔
    const double radius = 3; // ドットのサイズ

    for (double y = 0; y < size.height; y += spacing) {
      for (double x = 0; x < size.width; x += spacing) {
        canvas.drawCircle(Offset(x, y), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
