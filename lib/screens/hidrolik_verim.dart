import 'package:flutter/material.dart';

class HydraulicEfficiencyDetailsScreen extends StatefulWidget {
  @override
  _HydraulicEfficiencyDetailsScreenState createState() => _HydraulicEfficiencyDetailsScreenState();
}

class _HydraulicEfficiencyDetailsScreenState extends State<HydraulicEfficiencyDetailsScreen> {
  TextEditingController debiController = TextEditingController();
  TextEditingController totalHMController = TextEditingController();
  TextEditingController nMotorController = TextEditingController();
  TextEditingController gucController = TextEditingController();

  String debiUnit = 'm³/h';
  String totalHMUnit = 'mSS';
  String nMotorUnit = '%';
  String gucUnit = 'kW';

  void _calculateNhidrolik() {
    double debiConv = double.tryParse(debiController.text) ?? 0.0;
    double totalHM = double.tryParse(totalHMController.text) ?? 0.0;
    double gucConv = double.tryParse(gucController.text) ?? 0.0;
    double nMotor = double.tryParse(nMotorController.text) ?? 0.0;

    if (debiConv == 0 || totalHM == 0 || gucConv == 0 || nMotor == 0) {
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
      double result = calculateNmotor(debiConv, totalHM, gucConv, nMotor);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Sonuç'),
            content: Text('NHidrolik değeri: ${result.toStringAsFixed(2)}'),
              //print("Sonuç: ${nHidrolik.toStringAsFixed(2)}");
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
        title: Text(
          'Hidrolik Verim Hesaplama',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        //title: Text('Motor Verimi'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: debiController, decoration: InputDecoration(labelText: 'Debi ($debiUnit)')),
            TextField(controller: totalHMController, decoration: InputDecoration(labelText: 'Basma Yüksekliği ($totalHMUnit)')),
            TextField(controller: gucController, decoration: InputDecoration(labelText: 'Güç ($gucUnit)')),
            TextField(controller: nMotorController, decoration: InputDecoration(labelText: 'Motor Verimi ($nMotorUnit)')),

            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _calculateNhidrolik,
              style: ElevatedButton.styleFrom(
                primary: Colors.black, // Buton rengini siyah olarak ayarlar
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32), // Buton boyutunu ayarlar
              ),
              child: Text(
                'Hesapla',
                style: TextStyle(fontSize: 18), // Yazı boyutunu ayarlar
              ),
            )
          ],
        ),
      ),
    );
  }
}

double calculateNmotor(double debiConv, double totalHM, double gucConv, double nMotor) {
  double nHidrolik = (debiConv * totalHM) / (gucConv * 367.2 * nMotor / 10000);
  return nHidrolik;
}