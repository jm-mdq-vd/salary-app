import 'package:flutter/material.dart';

class InputBox extends StatefulWidget {
  const InputBox({
    Key? key,
    required this.hintText,
    required this.handler,
  }) : super(key: key);

  final String hintText;
  final Function(double) handler;

  @override
  State<InputBox> createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  final _controller = TextEditingController();

  String _textValue = '0.0';
  double get _value => double.parse(_textValue);

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      _textValue = _controller.text.isNotEmpty ? _controller.text : '0.0';
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 1,
      controller: _controller,
      onEditingComplete: () {
        setState(() {
          widget.handler(_value);
        });
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: widget.hintText,
      ),
    );
  }
}
