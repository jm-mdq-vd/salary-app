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
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('SALARY'),
        ),
        body: const MainView(),
      ),
    );
  }
}

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final double percentage = 0.17;
  double fullSalary = 0.0;

  double get remainingSalaryValue => fullSalary - (fullSalary * percentage);
  double get parallelDollarSalaryValue => remainingSalaryValue / 285.00;
  String get remainingSalary => remainingSalaryValue.toStringAsFixed(2);
  String get parallelDollarSalary => parallelDollarSalaryValue.toStringAsFixed(2);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          color: const Color.fromRGBO(226, 247, 249, 1.0),
          height: MediaQuery.of(context).size.height * 0.60,
          padding: const EdgeInsets.symmetric(
            vertical: 24.0,
            horizontal: 16.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InputBox(
                hintText: 'Ingresar salario en dolares',
                handler: (salary) {
                  final fullSalary = salary * 161.50;
                  setState(() {
                    this.fullSalary = fullSalary;
                  });
                },
              ),
            ],
          ),
        ),
        const Spacer(),
        Column(
          children: [
            ResultCell(
              label: 'Salario Bruto: ',
              value: '$fullSalary',
            ),
            const SizedBox(height: 8,),
            ResultCell(
              label: 'Salario Neto: ',
              value: remainingSalary,
            ),
            const SizedBox(height: 8,),
            ResultCell(
              label: 'Salario Neto en Dolares: ',
              value: parallelDollarSalary,
            ),
          ],
        )
      ],
    );
  }
}

class ResultCell extends StatelessWidget {
  const ResultCell({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  final String label;
  final String value;

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
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            Text(
              value,
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ],
        ),
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
