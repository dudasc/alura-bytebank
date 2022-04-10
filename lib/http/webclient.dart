import 'package:bytebank_app/http/interceptors/Logging_interceptor.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

final Client client = InterceptedClient.build(
  interceptors: [LoggingInterceptor()],
);

const String baseUrl = 'http://192.168.3.7:8080/transactions';


