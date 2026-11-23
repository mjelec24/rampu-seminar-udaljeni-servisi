import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'app_exception.dart';

Future<dynamic> sendRequest(Future<http.Response> request) async {
  try {
    final response = await request.timeout(const Duration(seconds: 10));
    debugPrint('HTTP ${response.statusCode} ${response.request?.url}');

    if (response.statusCode == 401) {
      throw UnauthorizedException();
    }
    if (response.statusCode != 200) {
      throw AppException('Greška poslužitelja (HTTP ${response.statusCode}).');
    }
    return jsonDecode(response.body);
  } on SocketException {
    throw AppException('Nema internetske veze.');
  } on http.ClientException {
    throw AppException('Nema internetske veze.');
  } on TimeoutException {
    throw AppException('Poslužitelj ne odgovara.');
  } on FormatException {
    throw AppException('Odgovor poslužitelja nije ispravan JSON.');
  }
}