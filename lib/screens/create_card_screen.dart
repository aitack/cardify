import 'package:flutter/material.dart';
import '../models/business_card.dart';

class CreateCardScreen extends StatefulWidget {
  const CreateCardScreen({super.key}); // ここを修正

  @override
  CreateCardScreenState createState() => CreateCardScreenState();
}

class CreateCardScreenState extends State<CreateCardScreen> {
  final _formKey = GlobalKey<FormState>();

  String _nickname = '';
  String _snsUsername = '';
  String _githubUsername = '';
  String _noteUsername = '';
  String _email = '';
  String _other = '';
  int _cardCount = 0;

  // フォームの保存処理
  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // BusinessCard のインスタンスを作成
      final newCard = BusinessCard(
        nickname: _nickname,
        snsUsername: _snsUsername,
        githubUsername: _githubUsername,
        noteUsername: _noteUsername,
        email: _email,
        other: _other,
        number: ++_cardCount, // 新しい番号をインクリメントして設定
      );

      Navigator.pop(context, newCard); // 戻り値として新しい名刺を渡す
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create a Business Card'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nickname'),
                onSaved: (value) => _nickname = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a nickname';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Instagram Username'),
                onSaved: (value) => _snsUsername = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Instagram username';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Github Username'),
                onSaved: (value) => _githubUsername = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Github username';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Note Username'),
                onSaved: (value) => _noteUsername = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Note username';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                onSaved: (value) => _email = value!,
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Other'),
                onSaved: (value) => _other = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveForm,
                child: Text('Save Card'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
