import 'dart:convert';

import 'package:http/http.dart';

import 'package:networking/models/dollar_api_response.dart';

enum Endpoint {
  official,
  parallel
}

extension EndpointHelpers on Endpoint {
  String get path {
    switch (this) {
      case Endpoint.official:
        return '/api/nacion';
      case Endpoint.parallel:
        return '/api/dolarblue';
    }
  }
}

abstract class ApiClient {
  Future<DollarAPIResponse> getInfoFrom(Endpoint endpoint);
}

class DollarApiClient implements ApiClient {
  static const String host = 'api-dolar-argentina.herokuapp.com';
  static const String scheme = 'https';

  @override
  Future<DollarAPIResponse> getInfoFrom(Endpoint endpoint) async {
    final url = Uri(
      scheme: scheme,
      host: host,
      path: endpoint.path,
    );
    final result = await get(url);
    final json = jsonDecode(result.body);
    return DollarAPIResponse.fromJson(json);
  }
}