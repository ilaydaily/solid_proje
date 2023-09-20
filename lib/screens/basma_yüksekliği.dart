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

  double result = 0.0;
  String errorMessage = '';

  String gucUnit = 'kW';
  String debiUnit = 'm³/h';
  String nMotorUnit = '%';
  String nHidrolikUnit = '%';

  void _calculateHM() {
    double gucConv = double.tryParse(gucController.text) ?? 0.0;
    double debiConv = double.tryParse(debiController.text) ?? 0.0;
    double nMotor = double.tryParse(nMotorController.text) ?? 0.0;
    double nHidrolik = double.tryParse(nHidrolikController.text) ?? 0.0;

    if (gucConv == 0 || debiConv == 0 || nMotor == 0 || nHidrolik == 0) {
      setState(() {
        errorMessage = 'Lütfen tüm alanları doldurun.';
        result = 0.0;
      });
    } else {
      setState(() {
        errorMessage = '';
        result = calculateHM(gucConv, nMotor, nHidrolik, debiConv);
      });

      /* double result = calculateHM(gucConv, nMotor, nHidrolik, debiConv);
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
    }*/
    } }

  void updateResultOnChange() {
    _calculateHM();
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
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Üst sıra kutucuklar
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white, // Kare kutucuk rengi
                          width: 1.0, // Kare kutucuk kenar kalınlığı
                        ),
                        borderRadius: BorderRadius.circular(
                            8.0), // Kare kutucuk köşeleri
                      ),
                      child: TextField(
                        controller: gucController,
                        onChanged: (value) => updateResultOnChange(),
                        decoration: InputDecoration(
                          labelText: 'Güç ($gucUnit)',
                          border: InputBorder.none, // Dış kenarı kaldırın
                          contentPadding:
                          EdgeInsets.all(8.0), // İçeriği hizalayın
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0), // Boşluk ekleyin
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white, // Kare kutucuk rengi
                          width: 1.0, // Kare kutucuk kenar kalınlığı
                        ),
                        borderRadius: BorderRadius.circular(
                            8.0), // Kare kutucuk köşeleri
                      ),
                      child: TextField(
                        controller: debiController,
                        onChanged: (value) => updateResultOnChange(),
                        decoration: InputDecoration(
                          labelText: 'Debi ($debiUnit)',
                          border: InputBorder.none, // Dış kenarı kaldırın
                          contentPadding:
                          EdgeInsets.all(8.0), // İçeriği hizalayın
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16.0), // Boşluk ekleyin

              // Alt sıra kutucuklar
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white, // Kare kutucuk rengi
                          width: 1.0, // Kare kutucuk kenar kalınlığı
                        ),
                        borderRadius: BorderRadius.circular(
                            8.0), // Kare kutucuk köşeleri
                      ),
                      child: TextField(
                        controller: nMotorController,
                        onChanged: (value) => updateResultOnChange(),
                        decoration: InputDecoration(
                          labelText: 'Motor Verimi ($nMotorUnit)',
                          border: InputBorder.none, // Dış kenarı kaldırın
                          contentPadding:
                          EdgeInsets.all(8.0), // İçeriği hizalayın
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0), // Boşluk ekleyin
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white, // Kare kutucuk rengi
                          width: 1.0, // Kare kutucuk kenar kalınlığı
                        ),
                        borderRadius: BorderRadius.circular(
                            8.0), // Kare kutucuk köşeleri
                      ),
                      child: TextField(
                        controller: nHidrolikController,
                        onChanged: (value) => updateResultOnChange(),
                        decoration: InputDecoration(
                          labelText: 'Hidrolik Verim ($nHidrolikUnit)',
                          border: InputBorder.none, // Dış kenarı kaldırın
                          contentPadding:
                          EdgeInsets.all(8.0), // İçeriği hizalayın
                        ),
                      ),
                      /* SizedBox(height: 16.0),
                        Text(
                          'Hidrolik Verim: % ${result.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),*/
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
                'Basma Yüksekliği:  ${result.toStringAsFixed(2)} mSS',
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),

              // SizedBox(height: 16.0), // Boşluk ekleyin

              // Kaydet düğmesi
              /* ElevatedButton(
                onPressed: () {
                  // Kullanıcının girdiği verileri alabilirsiniz.
                  String debi = controller1.text;
                  String hm = controller2.text;
                  String nHidrolik = controller3.text;
                  String nMotor = controller4.text;

                  // Verileri işlemek veya kaydetmek için burada yapılacak işlemleri ekleyebilirsiniz.

                  // Örnek olarak, verileri yazdırabiliriz:
                  print('Debi: $debi');
                  print('Basma Yüksekliği: $hm');
                  print('Hidrolik Verim: $nHidrolik');
                  print('Motor Verimi: $nMotor');
                },
                child: Text('Kaydet'),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}

double calculateHM(double gucConv, double nMotor, double nHidrolik, double debiConv) {
  double basmaYuksekligi =
      (gucConv * nMotor * nHidrolik * 367.2) / (debiConv * 10000);
  return basmaYuksekligi;
}
