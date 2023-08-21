import 'package:flutter/material.dart';

class FlowDetailsScreen extends StatefulWidget {
  @override
  _FlowDetailsScreenState createState() => _FlowDetailsScreenState();
}

class _FlowDetailsScreenState extends State<FlowDetailsScreen> {
  TextEditingController gucController = TextEditingController();
  TextEditingController totalHMController = TextEditingController();
  TextEditingController nMotorController = TextEditingController();
  TextEditingController nHidrolikController = TextEditingController();

  String gucUnit = 'kW';
  String totalHMUnit = 'mSS';
  String nMotorUnit = '%';
  String nHidrolikUnit = '%';

  void _calculateDebi() {
    double gucConv = double.tryParse(gucController.text) ?? 0.0;
    double totalHM = double.tryParse(totalHMController.text) ?? 0.0;
    double nMotor = double.tryParse(nMotorController.text) ?? 0.0;
    double nHidrolik = double.tryParse(nHidrolikController.text) ?? 0.0;

    if (gucConv == 0 || totalHM == 0 || nMotor == 0 || nHidrolik == 0) {
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
      double result = calculateDebi(gucConv, totalHM, nMotor, nHidrolik);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Sonuç'),
            content: Text('Debi değeri: ${result.toStringAsFixed(2)}'),
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
          'Debi Hesaplama',
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
            TextField(controller: totalHMController, decoration: InputDecoration(labelText: 'Basma Yüksekliği ($totalHMUnit)')),
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

double calculateDebi(double gucConv, double totalHM, double nMotor, double nHidrolik) {
  double debi = (gucConv * nMotor * nHidrolik * 367.2) / (totalHM / 10000);
  return debi;
}