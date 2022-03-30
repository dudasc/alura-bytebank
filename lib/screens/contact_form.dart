import 'package:bytebank_app/database/app_database.dart';
import 'package:bytebank_app/models/contact.dart';
import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _accountNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New contact')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  label: Text('Full name'),
                ),
                style: const TextStyle(fontSize: 24.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                controller: _accountNumberController,
                decoration: const InputDecoration(
                  label: Text('Account number'),
                ),
                style: const TextStyle(fontSize: 24.0),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () {
                    final String name = _nameController.text;
                    final int? accountNumber = int.tryParse(_accountNumberController.text);

                    final Contact newContact = Contact(0, name, accountNumber);

                    save(newContact).then((value) => Navigator.pop(context));
                  },
                  child: Text('Create'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
