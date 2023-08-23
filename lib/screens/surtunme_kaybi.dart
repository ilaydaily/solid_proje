import 'package:flutter/material.dart';

class CableDetailsScreen extends StatefulWidget {
  @override
  _CableDetailsScreenState createState() => _CableDetailsScreenState();
}

class _CableDetailsScreenState extends State<CableDetailsScreen> {
  TextEditingController malzemeController = TextEditingController();
  TextEditingController sicaklikController = TextEditingController();
  TextEditingController debiController = TextEditingController();
  TextEditingController boruCapiController = TextEditingController();
  TextEditingController boruUzunluguController = TextEditingController();

  List<String> malzemeUnitOptions = ['Aliminyum', 'Bakır'];
  List<String> sicaklikUnitOptions = ['C', 'F'];
  List<String> debiUnitOptions = ['m³/h', 'l/s'];
  List<String> boruCapiUnitOptions = ['mm', 'cm'];
  List<String> boruUzunluguUnitOptions = ['m', 'ft'];

  String malzemeUnit = 'Aliminyum';
  String sicaklikUnit = 'C';
  String debiUnit = 'm³/h';
  String boruCapiUnit = 'mm';
  String boruUzunluguUnit = 'm';

  void _calculateNhidrolik() {
    double sicaklik = double.tryParse(sicaklikController.text) ?? 0.0;
    double debi = double.tryParse(debiController.text) ?? 0.0;
    double cap = double.tryParse(boruCapiController.text) ?? 0.0;
    double uzunluk = double.tryParse(boruUzunluguController.text) ?? 0.0;

    if (sicaklik == 0 || debi == 0 || cap == 0 || uzunluk == 0) {
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
      double result = calculateNhidrolik(sicaklik, debi, cap, uzunluk);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Sonuç'),
            content: Text('Sürtünme Kaybı Değeri: ${result.toStringAsFixed(2)}'),
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
          'Sürtünme Kaybı',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        //title: Text('Motor Verimi'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: malzemeController,
                    decoration: InputDecoration(labelText: 'Boru Malzemesi'),
                  ),
                ),
                DropdownButton<String>(
                  value: malzemeUnit,
                  onChanged: (String? newValue) {
                    setState(() {
                      malzemeUnit = newValue!;
                    });
                  },
                  items: malzemeUnitOptions.map<DropdownMenuItem<String>>(
                        (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    },
                  ).toList(),
                  underline: Container(), // Bu satır ile altındaki çizgiyi kaldır
                ),
              ],
            ),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: sicaklikController,
                    decoration: InputDecoration(labelText: 'Sıcaklık'),
                  ),
                ),
                DropdownButton<String>(
                  value: sicaklikUnit,
                  onChanged: (String? newValue) {
                    setState(() {
                      sicaklikUnit = newValue!;
                    });
                  },
                  items: sicaklikUnitOptions.map<DropdownMenuItem<String>>(
                        (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    },
                  ).toList(),
                  underline: Container(), // Bu satır ile altındaki çizgiyi kaldır
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: debiController,
                    decoration: InputDecoration(labelText: 'Debi'),
                  ),
                ),
                DropdownButton<String>(
                  value: debiUnit,
                  onChanged: (String? newValue) {
                    setState(() {
                      debiUnit = newValue!;
                    });
                  },
                  items: debiUnitOptions.map<DropdownMenuItem<String>>(
                        (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    },
                  ).toList(),
                  underline: Container(),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: boruCapiController,
                    decoration: InputDecoration(labelText: 'Boru Çapı'),
                  ),
                ),
                DropdownButton<String>(
                  value: boruCapiUnit,
                  onChanged: (String? newValue) {
                    setState(() {
                      boruCapiUnit = newValue!;
                    });
                  },
                  items: boruCapiUnitOptions.map<DropdownMenuItem<String>>(
                        (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    },
                  ).toList(),
                  underline: Container(),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: boruUzunluguController,
                    decoration: InputDecoration(labelText: 'Boru Uzunluğu'),
                  ),
                ),
                DropdownButton<String>(
                  value: boruUzunluguUnit,
                  onChanged: (String? newValue) {
                    setState(() {
                      boruUzunluguUnit = newValue!;
                    });
                  },
                  items: boruUzunluguUnitOptions.map<DropdownMenuItem<String>>(
                        (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    },
                  ).toList(),
                  underline: Container(),
                ),
              ],
            ),
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

  double calculateNhidrolik(double sicaklik, double debi, double cap, double uzunluk) {
    // Hesaplama fonksiyonunu burada düzgün şekilde implement etmelisiniz.
    // Bu sadece bir örnek fonksiyon.
    double result = (debi * cap) / (sicaklik * uzunluk);
    return result;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cable Details',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CableDetailsScreen(),
    );
  }
}
