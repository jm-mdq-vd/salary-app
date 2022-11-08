class DollarAPIResponse {
  DollarAPIResponse({
    required this.date,
    required this.buy,
    required this.sell,
  });

  final String date;
  final String buy;
  final String sell;

  factory DollarAPIResponse.fromJson(Map<String, dynamic> json) {
    return DollarAPIResponse(
      date: json['fecha'],
      buy: json['compra'],
      sell: json['venta'],
    );
  }
}