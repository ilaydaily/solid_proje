import 'package:flutter/material.dart';
import 'package:solid_proje/screens/guc.dart';
import 'package:solid_proje/screens/motor_verimi.dart';
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
          builder: (context) => MotorVerimiScreen(),
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