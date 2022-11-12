import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:networking/client/api_client.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:networking/models/dollar_api_response.dart';

import 'api_client_test.mocks.dart';

@GenerateMocks([Client])
void main() {
  group('APIClient Tests', () {
    test('Fetch official dollar', () async {
      _performNetworkCall(
        url: 'https://api-dolar-argentina.herokuapp.com/api/nacion',
        endpoint: DollarAPIEndpoint.official,
      );
    });

    test('Failed to fetch official dollar', () async {
      _performNetworkCall(
        url: 'https://api-dolar-argentina.herokuapp.com/api/nacion',
        endpoint: DollarAPIEndpoint.official,
        isError: false,
      );
    });

    test('Fetch parallel dollar', () async {
      _performNetworkCall(
        url: 'https://api-dolar-argentina.herokuapp.com/api/dolarblue',
        endpoint: DollarAPIEndpoint.parallel,
      );
    });

    test('Failed to fetch parallel dollar', () async {
      _performNetworkCall(
        url: 'https://api-dolar-argentina.herokuapp.com/api/dolarblue',
        endpoint: DollarAPIEndpoint.parallel,
        isError: false,
      );
    });
  });
}

void _performNetworkCall({required String url, required DollarAPIEndpoint endpoint, bool isError = false,}) async {
  final client = MockClient();
  DollarApiClient.shared.client = client;

  final response = isError ?
    Response('Not Found', 400) :
    Response('{"fecha": "2022/11/12 17:52:02", "compra": "153.50", "venta": "161.50"}', 200);

  final expectedValue = isError ? throwsException : isA<DollarAPIResponse>();
  when(client.get(Uri.parse(url),),)
      .thenAnswer((_) async => response);

  expect(await DollarApiClient.shared.getInfoFrom(endpoint), expectedValue);
}