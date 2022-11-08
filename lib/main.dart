import 'dart:developer' as devtools;

import 'package:flutter/material.dart';

void main() {
  runApp(const SalaryApp());
}

class SalaryApp extends StatelessWidget {
  const SalaryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.teal,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('SALARY'),
        ),
        body: const MainView(),
      ),
    );
  }
}

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

  final double percentage = 0.17;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 24.0,
        horizontal: 16.0,
      ),
      child: Column(
        children: [
          InputBox(
            hintText: 'Ingresar salario',
            handler: (salary) {
              devtools.log('Salario Neto: ${salary - (salary * percentage)}');
            },
          ),
        ],
      ),
    );
  }
}


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
          devtools.log('Base Salary: $_value');
          widget.handler(_value);
        });
      },
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: widget.hintText,
      ),
    );
  }
}
