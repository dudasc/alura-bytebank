import 'dart:convert';

import 'package:bytebank_app/http/webclient.dart';
import 'package:bytebank_app/models/contact.dart';
import 'package:bytebank_app/screens/transactions_list.dart';
import 'package:http/http.dart';

class TransactionWebclient {
  Future<List<Transaction>> findAll() async {
    final Response response = await client.get(Uri.parse(baseUrl)).timeout(const Duration(seconds: 5));

    List<Transaction> transactions = _toTransactions(response);

    return transactions;
  }

  Future<Transaction> save(Transaction transaction) async {
    Map<String, dynamic> transactionMap = _toMap(transaction);

    final String transactionJson = jsonEncode(transactionMap);

    final response = await client.post(Uri.parse(baseUrl), headers: {'Content-Type': 'application/json', 'password': '1000'}, body: transactionJson);

    return _toTransaction(response);
  }

  List<Transaction> _toTransactions(Response response) {
    final List<dynamic> decodeJson = jsonDecode(response.body);
    final List<Transaction> transactions = [];

    for (Map<String, dynamic> transactionJson in decodeJson) {
      final Map<String, dynamic> contactJson = transactionJson['contact'];
      final Transaction transaction = Transaction(
        transactionJson['value'],
        Contact(
          0,
          contactJson['name'],
          contactJson['accountNumber'],
        ),
      );
      transactions.add(transaction);
    }

    return transactions;
  }

  Map<String, dynamic> _toMap(Transaction transaction) {
    final Map<String, dynamic> transactionMap = {
      'value': transaction.value,
      'contact': {'name': transaction.contact.name, 'accountNumber': transaction.contact.accountNumber}
    };

    return transactionMap;
  }

  Transaction _toTransaction(Response response) {
    Map<String, dynamic> json = jsonDecode(response.body);
    final Map<String, dynamic> contactJson = json['contact'];
    return Transaction(
      json['value'],
      Contact(
        0,
        contactJson['name'],
        contactJson['accountNumber'],
      ),
    );
  }
}
