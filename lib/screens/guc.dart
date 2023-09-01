import 'package:flutter/material.dart';

class PowerDetailsScreen extends StatefulWidget {
  @override
  _PowerDetailsScreenState createState() => _PowerDetailsScreenState();
}

class _PowerDetailsScreenState extends State<PowerDetailsScreen> {
  TextEditingController debiController = TextEditingController();
  TextEditingController hmController = TextEditingController();
  TextEditingController hidrVrmController = TextEditingController();
  TextEditingController motorVrmController = TextEditingController();

  double result = 0.0;
  String errorMessage = '';

  String debiUnit = 'm³/h';
  String totalHMUnit = 'mSS';
  String nMotorUnit = '%';
  String nHidrolikUnit = '%';

  void _calculatePower() {
    double debi_conv = double.tryParse(debiController.text) ?? 0.0;
    double total_HM = double.tryParse(hmController.text) ?? 0.0;
    double NMotor = double.tryParse(hidrVrmController.text) ?? 0.0;
    double NHidrolik = double.tryParse(motorVrmController.text) ?? 0.0;

    if (debi_conv == 0 || total_HM == 0 || NMotor == 0 || NHidrolik == 0) {
      setState(() {
        errorMessage = 'Lütfen tüm alanları doldurun.';
        result = 0.0;
      });
    } else {
      setState(() {
        errorMessage = '';
        result = calculatePower(debi_conv, total_HM, NMotor, NHidrolik);
      });
    } }

  void updateResultOnChange() {
    _calculatePower();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Güç Hesaplama',
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
                          width: 1.0, //kutucuk kenar kalınlığı
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextField(
                        controller: debiController,
                        onChanged: (value) => updateResultOnChange(),
                        decoration: InputDecoration(
                          labelText: 'Debi ($debiUnit)',
                          border: InputBorder.none, // Dış kenarı kaldır
                          contentPadding:
                          EdgeInsets.all(8.0), // İçeriği hizala
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
                        controller: hmController,
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
                        controller: motorVrmController,
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
                        controller: hidrVrmController,
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
                'Güç:  ${result.toStringAsFixed(2)} kW',
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

double calculatePower(double debi_conv, double total_HM, double NMotor, double NHidrolik) {
  double guc = (debi_conv * total_HM) / (NMotor * 367.2 * NHidrolik/10000);
  return guc;
}