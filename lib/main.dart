import 'package:flutter/material.dart';

import 'widgets/input_box/input_box.dart';
import 'widgets/cells/result_cell.dart';

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
            ResultCell(
              label: 'Salario Neto: ',
              value: remainingSalary,
            ),
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