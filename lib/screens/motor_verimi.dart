import 'package:flutter/material.dart';

class MotorVerimiScreen extends StatefulWidget {
  @override
  _MotorVerimiScreenState createState() => _MotorVerimiScreenState();
}

class _MotorVerimiScreenState extends State<MotorVerimiScreen> {
  TextEditingController debiController = TextEditingController();
  TextEditingController totalHMController = TextEditingController();
  TextEditingController nHidrolikController = TextEditingController();
  TextEditingController gucController = TextEditingController();

  void _calculateNmotor() {
    double debiConv = double.tryParse(debiController.text) ?? 0.0;
    double totalHM = double.tryParse(totalHMController.text) ?? 0.0;
    double gucConv = double.tryParse(gucController.text) ?? 0.0;
    double nHidrolik = double.tryParse(nHidrolikController.text) ?? 0.0;

    if (debiConv == 0 || totalHM == 0 || gucConv == 0 || nHidrolik == 0) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Uyarı'),
            content: Text('Lütfen tüm değerleri giriniz.'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Tamam'),
              ),
            ],
          );
        },
      );
    } else {
      double result = calculateNmotor(debiConv, totalHM, gucConv, nHidrolik);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Sonuç'),
            content: Text('Nmotor değeri: $result'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Tamam'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nmotor Hesaplama'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: debiController, decoration: InputDecoration(labelText: 'Debi Conv')),
            TextField(controller: totalHMController, decoration: InputDecoration(labelText: 'Total HM')),
            TextField(controller: gucController, decoration: InputDecoration(labelText: 'Guc Conv')),
            TextField(controller: nHidrolikController, decoration: InputDecoration(labelText: 'NHidrolik')),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _calculateNmotor,
              child: Text('Nmotor Hesapla'),
            ),
          ],
        ),
      ),
    );
  }
}

double calculateNmotor(double debiConv, double totalHM, double gucConv, double nHidrolik) {
  double nMotor = (debiConv * totalHM) / (gucConv * 367.2 * nHidrolik);
  return nMotor;
}