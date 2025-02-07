import 'package:flutter/material.dart';
import '../models/business_card.dart';
import 'business_card_preview_screen.dart'; // 名刺プレビュー画面

class CreateCardScreen extends StatefulWidget {
  @override
  _CreateCardScreenState createState() => _CreateCardScreenState();
}

class _CreateCardScreenState extends State<CreateCardScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _jobTitle = '';
  String _email = '';
  String _phone = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Digital Business Card')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                onSaved: (value) => _name = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Job Title'),
                onSaved: (value) => _jobTitle = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your job title';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                onSaved: (value) => _email = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone'),
                onSaved: (value) => _phone = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // 名刺情報を作成して、次の画面に遷移
                    final card = BusinessCard(
                      name: _name,
                      jobTitle: _jobTitle,
                      email: _email,
                      phone: _phone,
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BusinessCardPreviewScreen(card: card),
                      ),
                    );
                  }
                },
                child: Text('Save Card'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
