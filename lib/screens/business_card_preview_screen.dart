import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../models/business_card.dart';

class BusinessCardPreviewScreen extends StatefulWidget {
  final BusinessCard card;

  const BusinessCardPreviewScreen({super.key, required this.card});

  @override
  BusinessCardPreviewScreenState createState() =>
      BusinessCardPreviewScreenState();
}

class BusinessCardPreviewScreenState extends State<BusinessCardPreviewScreen> {
  double _offsetY = 0.0;

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _offsetY += details.primaryDelta ?? 0;
    });
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    setState(() {
      if (_offsetY > 50) {
        _offsetY = 0;
      } else if (_offsetY < -50) {
        _offsetY = -150;
      } else {
        _offsetY = 0;
      }
    });
  }

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
    double screenHeight = MediaQuery.of(context).size.height;
    double cardHeight = screenHeight * 0.6;
    double initialTop = screenHeight * 0.2;

    double qrCodeSize = cardHeight * 0.3; // QRコードのサイズをカード高さの30%に設定

    return Scaffold(
      appBar: AppBar(title: Text('Business Card Preview')),
      body: Stack(
        alignment: Alignment.center,
        children: [
          GestureDetector(
            onVerticalDragUpdate: _onVerticalDragUpdate,
            onVerticalDragEnd: _onVerticalDragEnd,
            child: Container(
              color: Colors.transparent, // スワイプ検出用の透明な背景
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 250),
            top: initialTop + _offsetY,
            left: MediaQuery.of(context).size.width * 0.1,
            right: MediaQuery.of(context).size.width * 0.1,
            child: GestureDetector(
              onVerticalDragUpdate: _onVerticalDragUpdate,
              onVerticalDragEnd: _onVerticalDragEnd,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: cardHeight,
                padding: const EdgeInsets.all(16), // 内側の余白を追加
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end, // ここで下端に配置
                  children: [
                    // QRコードとリンク集を横並びに配置
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // リンク集の部分
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 16), // QRコードとの間隔を調整
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.card.nickname,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 12),
                                _buildTapableLink(
                                    FontAwesomeIcons.instagram,
                                    'https://www.instagram.com/${widget.card.snsUsername}',
                                    '@${widget.card.snsUsername}'),
                                _buildTapableLink(
                                    FontAwesomeIcons.github,
                                    'https://github.com/${widget.card.githubUsername}',
                                    '@${widget.card.githubUsername}'),
                                _buildTapableLink(
                                    FontAwesomeIcons.solidNoteSticky,
                                    'https://note.com/${widget.card.noteUsername}',
                                    '@${widget.card.noteUsername}'),
                                _buildTapableLink(
                                    FontAwesomeIcons.envelope,
                                    'mailto:${widget.card.email}',
                                    widget.card.email),
                              ],
                            ),
                          ),
                        ),
                        // QRコードの部分
                        SizedBox(
                          width: qrCodeSize,
                          height: qrCodeSize,
                          child: QrImageView(
                            data: 'Nickname: ${widget.card.nickname}\n'
                                'SNS: ${widget.card.snsUsername}\n'
                                'Github: ${widget.card.githubUsername}\n'
                                'Note: ${widget.card.noteUsername}\n'
                                'Email: ${widget.card.email}\n'
                                'Other: ${widget.card.other}',
                            version: QrVersions.auto,
                            size: qrCodeSize, // 動的にサイズ設定
                            errorCorrectionLevel: QrErrorCorrectLevel.H,
                            eyeStyle: QrEyeStyle(
                              eyeShape: QrEyeShape.circle,
                              color: Color(0xFFFB9DA9),
                            ),
                            dataModuleStyle: QrDataModuleStyle(
                              dataModuleShape: QrDataModuleShape.circle,
                              color: Color(0xFFFB9DA9),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTapableLink(IconData icon, String url, String text) {
    return GestureDetector(
      onTap: () => _launchURL(url),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Icon(icon, size: 18, color: Color(0xFFFB9DA9)),
              SizedBox(width: 8),
              Text(
                text,
                style: TextStyle(fontSize: 14, color: Color(0xFFFB9DA9)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
