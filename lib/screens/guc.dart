import 'package:flutter/material.dart';

class PowerDetailsScreen extends StatefulWidget {
  //final String colorName;
  // PowerDetailsScreen({required this.colorName});

  @override
  _PowerDetailsScreenState createState() => _PowerDetailsScreenState();
}

class _PowerDetailsScreenState extends State<PowerDetailsScreen> {
  TextEditingController debiController = TextEditingController();
  TextEditingController hmController = TextEditingController();
  TextEditingController hidrVrmController = TextEditingController();
  TextEditingController motorVrmController = TextEditingController();

  String result = ' ';

  //double diameter = 0.0;
  double guc = 0.0;

  void operate() {
    // Define your operate function logic here
  }

  double advancedResult() {

    if(debiController.text.isNotEmpty && hmController.text.isNotEmpty
        && hidrVrmController.text.isNotEmpty && motorVrmController.text.isNotEmpty){
      double debi_conv = double.parse(debiController.text.replaceAll(',', '.'));
      double total_HM = double.parse(hmController.text.replaceAll(',', '.'));
      double NMotor = double.parse(motorVrmController.text.replaceAll(',', '.'));
      double NHidrolik = double.parse(hidrVrmController.text.replaceAll(',', '.'));

      if(NMotor * NHidrolik != 0){
        var guc = (debi_conv * total_HM) / (NMotor * 367.2 * NHidrolik);
      }
      else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Dikkat!'),
              content: Text('Sayılar Dengeli Değil!'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Tamam'),
                ),
              ],
            );
          },
        );
      }
    }
    else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Dikkat!'),
            content: Text('Girilmeyen Alanları Doldurun!'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Tamam'),
              ),
            ],
          );
        },
      );
    }
    return guc;
  }

  @override
  void initState() {
    super.initState();
    debiController.addListener(_updateResult);
    hmController.addListener(_updateResult);
    hidrVrmController.addListener(_updateResult);
    motorVrmController.addListener(_updateResult);
  }

  void _updateResult() {
    double powerResult = calculatePower();
    setState(() {
      result = 'Sonuç: $powerResult';
    });
  }

  double calculatePower() {

    double debi_conv = double.tryParse(debiController.text) ?? 0.0;
    double total_HM = double.tryParse(hmController.text) ?? 0.0;
    double NMotor = double.tryParse(hidrVrmController.text) ?? 0.0;
    double NHidrolik = double.tryParse(motorVrmController.text) ?? 0.0;

    // Burada güç hesaplama işlemlerini gerçekleştirin, örneğin:
    // double result = value1 + value2 + value3 + value4;
    double guc = (debi_conv * total_HM) / (NMotor * 367.2 * NHidrolik/10000);

    return guc;
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              result,
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSquare("Debi", debiController),
                SizedBox(width: 10),
                _buildSquare("Basma Yüksekliği",hmController),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSquare("Hidrolik Verim", hidrVrmController),
                SizedBox(width: 10),
                _buildSquare("Motor Verimi",motorVrmController),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Add your code here to handle the tap/click action
                      // For example, you can show a dialog or navigate to a new screen.
                      print('container tapped!');
                      _updateResult();
                    },
                    child: Container(
                      width: 310,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      alignment: Alignment.center,
                      child: Text('HESAPLA'),
                    ),
                  ),
                ],
              ),
            )
            //),
          ],
        ),
      ),
    );
  }

  Widget _buildSquare(String additionalText, TextEditingController controller) {
    return GestureDetector(
      onTap: () {
        _showInputDialog(controller);
      },
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white60,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(5),
        ),
        alignment: Alignment.center,
        child: Column( // Use a Column to stack content vertically
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              controller.text,
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(height: 10), // Add spacing between the text
            Text(
              additionalText,
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  void _showInputDialog(TextEditingController controller) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Veri Girin"),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.text,
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Tamam"),
            ),
          ],
        );
      },
    );
  }
}