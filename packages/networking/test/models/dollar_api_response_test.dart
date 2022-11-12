import 'package:networking/models/dollar_api_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('From JSON method should generate a valid instance', () {
    final json = {
      "fecha": "2022/11/12 15:31:15",
      "compra": "285.00",
      "venta": "289.00"
    };
    final response = DollarAPIResponse.fromJson(json);
    expect(response.date, "2022/11/12 15:31:15");
    expect(response.buy, "285.00");
    expect(response.sell, "289.00");
  });
}