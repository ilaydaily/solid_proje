import 'package:flutter/material.dart';

class HMDetailsScreen extends StatefulWidget {
  @override
  _HMDetailsScreenState createState() => _HMDetailsScreenState();
}

class _HMDetailsScreenState extends State<HMDetailsScreen> {
  TextEditingController gucController = TextEditingController();
  TextEditingController debiController = TextEditingController();
  TextEditingController nMotorController = TextEditingController();
  TextEditingController nHidrolikController = TextEditingController();

  String gucUnit = 'kW';
  String debiUnit = 'm³/h';
  String nMotorUnit = '%';
  String nHidrolikUnit = '%';

  void _calculateDebi() {
    double gucConv = double.tryParse(gucController.text) ?? 0.0;
    double debiConv = double.tryParse(debiController.text) ?? 0.0;
    double nMotor = double.tryParse(nMotorController.text) ?? 0.0;
    double nHidrolik = double.tryParse(nHidrolikController.text) ?? 0.0;

    if (gucConv == 0 || debiConv == 0 || nMotor == 0 || nHidrolik == 0) {
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
      double result = calculateHM(gucConv, nMotor, nHidrolik, debiConv);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Sonuç'),
            content: Text('HM değeri: ${result.toStringAsFixed(2)}'),
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
          'Basma Yüksekliği Hesaplama',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        //title: Text('Motor Verimi'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: gucController, decoration: InputDecoration(labelText: 'Güç ($gucUnit)')),
            TextField(controller: debiController, decoration: InputDecoration(labelText: 'Debi ($debiUnit)')),
            TextField(controller: nMotorController, decoration: InputDecoration(labelText: 'Motor Verimi ($nMotorUnit)')),
            TextField(controller: nHidrolikController, decoration: InputDecoration(labelText: 'Hidrolik Verim ($nHidrolikUnit)')),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _calculateDebi,
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

double calculateHM(double gucConv, double nMotor, double nHidrolik, double debiConv) {
  double basmaYuksekligi = (gucConv * nMotor * nHidrolik * 367.2) / (debiConv / 10000);
  return basmaYuksekligi;
}