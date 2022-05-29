import 'dart:convert';

import 'package:bytebank_app/http/webclient.dart';
import 'package:bytebank_app/models/transaction.dart';
import 'package:http/http.dart';

class TransactionWebclient {
  Future<List<Transaction>> findAll() async {
    final Response response = await client.get(Uri.parse(baseUrl)).timeout(const Duration(seconds: 5));

    List<Transaction> transactions = _toTransactions(response);

    return transactions;
  }

  Future<Transaction> save(Transaction transaction) async {
    final String transactionJson = jsonEncode(transaction.toJson());

    final response = await client.post(Uri.parse(baseUrl), headers: {'Content-Type': 'application/json', 'password': '1000'}, body: transactionJson);

    return _toTransaction(response);
  }

  List<Transaction> _toTransactions(Response response) {
    final List<dynamic> decodeJson = jsonDecode(response.body);
    final List<Transaction> transactions = [];

    for (Map<String, dynamic> transactionJson in decodeJson) {
      transactions.add(Transaction.fromJson(transactionJson));
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

    return Transaction.fromJson(json);
  }
}
