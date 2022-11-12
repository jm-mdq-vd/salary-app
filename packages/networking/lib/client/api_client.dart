import 'dart:convert';

import 'package:http/http.dart';

import 'package:networking/models/dollar_api_response.dart';

enum DollarAPIEndpoint {
  official,
  parallel
}

extension EndpointHelpers on DollarAPIEndpoint {
  String get path {
    switch (this) {
      case DollarAPIEndpoint.official:
        return '/api/nacion';
      case DollarAPIEndpoint.parallel:
        return '/api/dolarblue';
    }
  }
}

abstract class ApiClient {
  Future<DollarAPIResponse> getInfoFrom(DollarAPIEndpoint endpoint);
}

class DollarApiClient implements ApiClient {
  static const String host = 'api-dolar-argentina.herokuapp.com';
  static const String scheme = 'https';

  DollarApiClient._privateConstructor();

  Client client = Client();

  static final DollarApiClient _instance = DollarApiClient._privateConstructor();

  static DollarApiClient get shared => _instance;

  @override
  Future<DollarAPIResponse> getInfoFrom(DollarAPIEndpoint endpoint) async {
    final url = Uri(
      scheme: scheme,
      host: host,
      path: endpoint.path,
    );
    final response = await client.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return DollarAPIResponse.fromJson(json);
    }

    throw Exception('Failed to get info from endpoint: $endpoint');
  }
}