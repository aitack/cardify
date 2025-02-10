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
        _offsetY = 100;
      } else if (_offsetY < -50) {
        _offsetY = 0;
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
    return Scaffold(
      appBar: AppBar(title: Text('Business Card Preview')),
      body: Stack(
        alignment: Alignment.center,
        children: [
          GestureDetector(
            onVerticalDragUpdate: _onVerticalDragUpdate,
            onVerticalDragEnd: _onVerticalDragEnd,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeOut,
              transform: Matrix4.translationValues(
                  MediaQuery.of(context).size.width / 2 -
                      MediaQuery.of(context).size.width * 0.8 / 2 -
                      16,
                  _offsetY,
                  0),
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
                          'Card #${widget.card.number}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(0, 0, 0, 0.6),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 16,
                        right: 16,
                        child: QrImageView(
                          data:
                              'Nickname: ${widget.card.nickname}\nSNS: ${widget.card.snsUsername}\nGithub: ${widget.card.githubUsername}\nNote: ${widget.card.noteUsername}\nEmail: ${widget.card.email}\nOther: ${widget.card.other}',
                          version: QrVersions.auto,
                          size: 120,
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
                      Positioned(
                        bottom: 16,
                        left: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                            Row(
                              children: [
                                Icon(FontAwesomeIcons.instagram,
                                    size: 18, color: Color(0xFFFB9DA9)),
                                SizedBox(width: 8),
                                GestureDetector(
                                  onTap: () => _launchURL(
                                      'https://www.instagram.com/${widget.card.snsUsername}'),
                                  child: Text(
                                    '@${widget.card.snsUsername}',
                                    style: TextStyle(
                                        fontSize: 14, color: Color(0xFFFB9DA9)),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(FontAwesomeIcons.github,
                                    size: 18, color: Color(0xFFFB9DA9)),
                                SizedBox(width: 8),
                                GestureDetector(
                                  onTap: () => _launchURL(
                                      'https://github.com/${widget.card.githubUsername}'),
                                  child: Text(
                                    '@${widget.card.githubUsername}',
                                    style: TextStyle(
                                        fontSize: 14, color: Color(0xFFFB9DA9)),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(FontAwesomeIcons.solidNoteSticky,
                                    size: 18, color: Color(0xFFFB9DA9)),
                                SizedBox(width: 8),
                                GestureDetector(
                                  onTap: () => _launchURL(
                                      'https://note.com/${widget.card.noteUsername}'),
                                  child: Text(
                                    '@${widget.card.noteUsername}',
                                    style: TextStyle(
                                        fontSize: 14, color: Color(0xFFFB9DA9)),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(FontAwesomeIcons.envelope,
                                    size: 18,
                                    color: Color(0xFFFB9DA9)), // ブランドカラー
                                SizedBox(width: 8),
                                GestureDetector(
                                  onTap: () =>
                                      _launchURL('mailto:${widget.card.email}'),
                                  child: Text(
                                    widget.card.email,
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
          ),
        ],
      ),
    );
  }
}
