import 'package:bytebank_app/models/contact.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> createDatabase() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = openDatabase(
    join(await getDatabasesPath(), 'bytebasnk.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE contacts('
        'id INTEGER PRIMARY KEY, '
        'name TEXT, '
        'account_number INTEGER)',
      );
    },
    version: 1,
  );

  return database;
}

Future<int> save(Contact contact) async {
  final db = await createDatabase();
  final Map<String, dynamic> contactMap = Map();

  contactMap['name'] = contact.name;
  contactMap['account_number'] = contact.accountNumber;

  return await db.insert('contacts', contactMap);
}

Future<List<Contact>> findAll() async {
  final db = await createDatabase();

  final List<Map<String, dynamic>> maps = await db.query('contacts');

  return List.generate(maps.length, (i) {
    return Contact(
      maps[i]['id'],
      maps[i]['name'],
      maps[i]['account_number'],
    );
  });  
}
