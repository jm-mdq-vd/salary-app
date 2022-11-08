import 'package:flutter/material.dart';

class ResultCell extends StatelessWidget {
  const ResultCell({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  final String label;
  final String value;

  TextStyle get style => const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 20.0,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      height: 50.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 4.0,
          horizontal: 16.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              textAlign: TextAlign.start,
              style: style,
            ),
            Text(
              value,
              textAlign: TextAlign.start,
              style: style,
            ),
          ],
        ),
      ),
    );
  }
}