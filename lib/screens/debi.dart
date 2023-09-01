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
  double result = 0.0;
  String errorMessage = '';

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
      setState(() {
        errorMessage = 'Lütfen tüm alanları doldurun.';
        result = 0.0;
      });
    } else {
      setState(() {
        errorMessage = '';
        result = calculateDebi(gucConv, totalHM, nMotor, nHidrolik);
      });
    } }

  void updateResultOnChange() {
    _calculateDebi();
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
                        controller: nMotorController,
                        onChanged: (value) => updateResultOnChange(),
                        decoration: InputDecoration(
                          labelText: 'Motor Verimi ($nMotorUnit)',
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
                'Debi:  ${result.toStringAsFixed(2)} m³/h',
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

double calculateDebi(double gucConv, double totalHM, double nMotor, double nHidrolik) {
  double debi = (gucConv * nMotor * nHidrolik * 367.2) / (totalHM * 10000);
  return debi;
}