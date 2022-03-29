import 'package:bytebank_app/database/app_database.dart';
import 'package:bytebank_app/models/contact.dart';
import 'package:bytebank_app/screens/dashboard.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(BytebankApp());
  save(Contact(10, 'alex', 1000)).then((id) {
    findAll().then((contacts) => debugPrint(contacts.toString()));
  });
}

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green[900],
        appBarTheme: AppBarTheme(
          color: Colors.green[900],
        ),
        accentColor: Colors.blueAccent[700],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blueAccent[700],
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: Dashboard(),
    );
  }
}
