import 'dart:convert';

import 'package:bytebank_app/models/contact.dart';
import 'package:bytebank_app/screens/transactions_list.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    // print(data.toString());
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    // print(data.toString());
    return data;
  }
}

final Client client = InterceptedClient.build(
  interceptors: [LoggingInterceptor()],
);

const String baseUrl = 'http://192.168.3.7:8080/transactions';

Future<List<Transaction>> findAll() async {
  final Response response = await client.get(Uri.parse(baseUrl)).timeout(const Duration(seconds: 5));

  final List<dynamic> decodeJson = jsonDecode(response.body);
  final List<Transaction> transactions = [];

  print('decoded json $decodeJson');

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

Future<Transaction> save(Transaction transaction) async {
  final Map<String, dynamic> transactionMap = {
    'value': transaction.value,
    'contact': {'name': transaction.contact.name, 'accountNumber': transaction.contact.accountNumber}
  };

  final String transactionJson = jsonEncode(transactionMap);

  final response = await client.post(Uri.parse(baseUrl), headers: {'Content-Type': 'application/json', 'password': '1000'}, body: transactionJson);

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
