import 'package:flutter/material.dart';

class Cell extends StatelessWidget {
  const Cell({
    Key? key,
    required this.label,
    required this.value,
    this.color = Colors.white,
    this.backgroundColor = Colors.grey,
  }) : super(key: key);

  final String label;
  final String value;
  final Color color;
  final Color backgroundColor;

  TextStyle get style => TextStyle(
    color: color,
    fontWeight: FontWeight.bold,
    fontSize: 20.0,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
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