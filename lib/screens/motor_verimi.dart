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
  double result = 0.0;
  String errorMessage = '';

  String debiUnit = 'm³/h';
  String totalHMUnit = 'mSS';
  String nHidrolikUnit = '%';
  String gucUnit = 'kW';

  void _calculateNmotor() {
    double debiConv = double.tryParse(debiController.text) ?? 0.0;
    double totalHM = double.tryParse(totalHMController.text) ?? 0.0;
    double gucConv = double.tryParse(gucController.text) ?? 0.0;
    double nHidrolik = double.tryParse(nHidrolikController.text) ?? 0.0;

    if (debiConv == 0 || totalHM == 0 || gucConv == 0 || nHidrolik == 0) {
      setState(() {
        errorMessage = 'Lütfen tüm alanları doldurun.';
        result = 0.0;
      });
    } else {
      setState(() {
        errorMessage = '';
        result = calculateNmotor(debiConv, totalHM, gucConv, nHidrolik);
      });
    } }

  void updateResultOnChange() {
    _calculateNmotor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Motor Verimi Hesaplama',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextField(
                        controller: debiController,
                        onChanged: (value) => updateResultOnChange(),
                        decoration: InputDecoration(
                          labelText: 'Debi ($debiUnit)',
                          border: InputBorder.none,
                          contentPadding:
                          EdgeInsets.all(8.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(
                            8.0),
                      ),
                      child: TextField(
                        controller: totalHMController,
                        onChanged: (value) => updateResultOnChange(),
                        decoration: InputDecoration(
                          labelText: 'Basma Yüksekliği ($totalHMUnit)',
                          border: InputBorder.none,
                          contentPadding:
                          EdgeInsets.all(8.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16.0),

              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(
                            8.0),
                      ),
                      child: TextField(
                        controller: gucController,
                        onChanged: (value) => updateResultOnChange(),
                        decoration: InputDecoration(
                          labelText: 'Güç ($gucUnit)',
                          border: InputBorder.none,
                          contentPadding:
                          EdgeInsets.all(8.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(
                            8.0),
                      ),
                      child: TextField(
                        controller: nHidrolikController,
                        onChanged: (value) => updateResultOnChange(),
                        decoration: InputDecoration(
                          labelText: 'Hidrolik Verim ($nHidrolikUnit)',
                          border: InputBorder.none,
                          contentPadding:
                          EdgeInsets.all(8.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Text(
                errorMessage,
                style: TextStyle(color: Colors.red),
              ),
              SizedBox(height: 16.0),
              Text(
                'Motor Verimi: % ${result.toStringAsFixed(2)} ',
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

double calculateNmotor(double debiConv, double totalHM, double gucConv, double nHidrolik) {
  double nMotor = (debiConv * totalHM) / (gucConv * 367.2 * nHidrolik / 10000);
  return nMotor;
}