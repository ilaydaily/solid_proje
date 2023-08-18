import 'package:flutter/material.dart';
//import 'dart:math' as math;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(), // Use dark theme
      home: ColorfulListViewScreen(),
    );
  }
}

class ColorfulListViewScreen extends StatelessWidget {
  final List<Color> _colors = [
    Colors.deepPurple,
    Colors.deepOrange,
    Colors.amber,
    Colors.teal,
    Colors.blueGrey,
    Colors.indigo,
    Colors.pink,
  ];

  final List<String> _colorNames = [
    'Güç',
    'Hidrolik Verim',
    'Debi',
    'Basma Yüksekliği',
    'Motor Verimi',
    'Kablo Maliyet',
    'Sürtünme Kaybı',
  ];

  final List<String> _imagePaths = [
    'lib/images/clampmeter.png',
    'lib/images/2hyraulic.jpg',
    'lib/images/2debi.jpg',
    'lib/images/2basma_yüksekliği.jpg',
    'lib/images/2motor.png',
    'lib/images/2friction_loss.jpg',
    'lib/images/2cable.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Solid Calculator',
          textAlign: TextAlign.center, // Başlık metnini ortalama
        ),
        centerTitle: true, // Başlığı ortala
      ),
      body: ListView.builder(
        itemCount: _colors.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _openColorDetails(context, _colorNames[index]);
            },
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: _colors[index],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10), // You can adjust the radius as needed
                        child: Image.asset(
                          _imagePaths[index],
                          width: 80,
                          height: 80,
                        ),
                      ),
                    ),
                    Text(
                      _colorNames[index],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

void _openColorDetails(BuildContext context, String colorName) {
  switch (colorName) {
    case 'Güç':
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PowerDetailsScreen(),
        ),
      );
      break;
    case 'Hidrolik Verim':
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HydraulicEfficiencyDetailsScreen(),
        ),
      );
      break;case 'Debi':
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PowerDetailsScreen(),
      ),
    );
    break;
    case 'Basma Yüksekliği':
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PowerDetailsScreen(),
        ),
      );
      break;
    case 'Motor Verimi':
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PowerDetailsScreen(),
        ),
      );
      break;
    case 'Kablo Maliyet':
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PowerDetailsScreen(),
        ),
      );
      break;
    case 'Sürtünme Kaybı':
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PowerDetailsScreen(),
        ),
      );
      break;
    default:
    // For other colors, you can handle navigation or show an error page.
      break;
  }
}

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

class HydraulicEfficiencyDetailsScreen extends StatefulWidget {
  @override
  _HydraulicEfficiencyDetailsScreenState createState() =>
      _HydraulicEfficiencyDetailsScreenState();
}

class _HydraulicEfficiencyDetailsScreenState
    extends State<HydraulicEfficiencyDetailsScreen> {
  // Declare any mutable state variables here, if needed.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hydraulic Efficiency',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'This is the details screen for Hydraulic Efficiency',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}