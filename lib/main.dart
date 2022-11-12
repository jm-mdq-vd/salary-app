import 'package:flutter/material.dart';
import 'package:networking/networking.dart';

import 'widgets/input_box/input_box.dart';
import 'widgets/cells/cell.dart';

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
  String get remainingSalary => remainingSalaryValue.toStringAsFixed(2);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        DollarApiClient.shared.getInfoFrom(DollarAPIEndpoint.official),
        DollarApiClient.shared.getInfoFrom(DollarAPIEndpoint.parallel),
      ]),
      builder: (BuildContext context, AsyncSnapshot<List<DollarAPIResponse>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        List<DollarAPIResponse> data = snapshot.data ?? [];

        final officialDollarSellPrice = double.parse(data[0]?.sell ?? '0.0');
        final parallelDollarBuyPrice = double.parse(data[1]?.buy ?? '0.0');

        String parallelDollarSalary = (remainingSalaryValue / parallelDollarBuyPrice).toStringAsFixed(2);

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
                      final fullSalary = salary * officialDollarSellPrice;
                      setState(() {
                        this.fullSalary = fullSalary;
                      });
                    },
                  ),
                  const SizedBox(height: 16.0,),
                  Column(
                    children: [
                      Cell(
                        label: 'Dolar Banco Nacion Venta: ',
                        value: officialDollarSellPrice.toStringAsFixed(2),
                        color: Colors.black,
                        backgroundColor: Colors.transparent,
                      ),
                      Cell(
                        label: 'Dolar Blue Comprar: ',
                        value: parallelDollarBuyPrice.toStringAsFixed(2),
                        color: Colors.black,
                        backgroundColor: Colors.transparent,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            Column(
              children: [
                Cell(
                  label: 'Salario Bruto: ',
                  value: fullSalary.toStringAsFixed(2),
                ),
                Cell(
                  label: 'Salario Neto: ',
                  value: remainingSalary,
                ),
                Cell(
                  label: 'Salario Neto en Dolares: ',
                  value: parallelDollarSalary,
                ),
              ],
            )
          ],
        );
      }
    );
  }
}