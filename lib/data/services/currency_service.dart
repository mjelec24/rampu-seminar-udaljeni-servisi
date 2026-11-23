import 'package:http/http.dart' as http;

import '../api.dart';

class CurrencyService {
  static const baseUrl = 'https://api.frankfurter.dev/v1';

  Future<double> getUsdToEur() async {
    final json = await sendRequest(
      http.get(Uri.parse('$baseUrl/latest?base=USD&symbols=EUR')),
    );
    return (json['rates']['EUR'] as num).toDouble();
  }
}