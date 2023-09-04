import 'package:flutter/material.dart';
import 'dart:math' as math;

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


/*
  Map<String, dynamic> calculatePumpEfficiency(
      double flow,
      double power,
      double innerDiameter,
      double k,
      double l,
      double temperature,
      double motorEfficiency,
      double waterLevel,
      double pressure,
      double exloss,
      ) {
    double calcVis(double t3) {
      if (t3 == null || t3 <= 0 || t3 > 100) {
        return 0;
      }

      const vis = [
        [0, 1.791468],
        [5, 1.517938],
        [10, 1.306096],
        [15, 1.138451],
        [20, 1.003317],
        [25, 0.892654],
        [30, 0.800782],
        [35, 0.723598],
        [40, 0.658075],
        [45, 0.601942],
        [50, 0.553461],
        [55, 0.511289],
        [60, 0.474368],
        [65, 0.441859],
        [70, 0.413086],
        [75, 0.387498],
        [80, 0.364647],
        [85, 0.344158],
        [90, 0.325721],
        [95, 0.309076],
        [100, 0.294002],
        [200, 0.294002]
      ];

      int i = vis.length;
      for (var v = 0; v < vis.length; v++) {
        if (t3 < vis[v][0]) {
          i = v;
          break;
        }
      }

      var t1 = vis[i - 1][0];
      var t2 = vis[i][0];
      var v1 = vis[i - 1][1];
      var v2 = vis[i][1];

      var v3 = ((t2 - t3) * (v1 - v2)) / (t2 - t1) + v2;

      return v3 / 1000000;
    }

    Map<String, dynamic> calcReynold(
        double rho,
        double u,
        double innerDiameter,
        double mu,
        double vi,
        ) {
      Map<String, dynamic> result = {};
      double re = -1;

      if (rho != null && u != null && innerDiameter != null && mu != null && mu != 0) {
        re = (rho * u * innerDiameter / mu).round() as double;
      }
      if (u != null && innerDiameter != null && vi != null) {
        re = (u * innerDiameter / vi);
      }

      if (re > 4000) {
        result["flow"] = "turbulans";
      } else if (re > 2300 && re < 4000) {
        result["flow"] = "turbulans - laminer";
      } else if (re < 2300) {
        result["flow"] = "laminer";
      }
      result["rn"] = re;

      return result;
    }

    double frictionCoefficient(
        double innerDiameter,
        double k,
        double re,
        ) {
      double lambda = 0.08;
      var leftL = 1 / math.sqrt(lambda);
      var rightL = -2 * math.log(2.51 / (re * math.sqrt(lambda)) + k / innerDiameter / 3.72);

      while (rightL - leftL >= 0) {
        leftL = 1 / math.sqrt(lambda);
        rightL = -2 * math.log(2.51 / (re * math.sqrt(lambda)) + k / innerDiameter / 3.72);

        lambda = lambda - 0.0005;
      }
      return lambda;
    }

    Map<String, dynamic> calcColebrook(
        double innerDiameter,
        double k,
        double u,
        double temperature,
        ) {
      Map<String, dynamic> result = {};
      result["vi"] = calcVis(temperature);

      Map<String, dynamic> rey = calcReynold(0, u, innerDiameter, 0, result["vi"]);
      result["ren"] = rey["rn"];
      result["fd"] = frictionCoefficient(innerDiameter, k, result["ren"]);
      result["rr"] = k / innerDiameter;

      result["turb"] = rey["flow"];
      return result;
    }

    double a = math.pi * math.pow(innerDiameter, 2) / 4;
    double u = flow / 3600 / a;
    var result = calcColebrook(innerDiameter, k, u, temperature);

    result["u"] = u;

    try {
      result["headLoss"] = (result["fd"] * l * math.pow(u, 2)) / (innerDiameter * (2 * 9.7905));
    } catch (_) {
      result["headLoss"] = exloss;
    }

    result["hm"] = (pressure * 10.197162 + waterLevel + result["headLoss"]);
    result["hydraulic"] = (result["hm"] * flow) / (367.2 * power * motorEfficiency / 10000);
    result["system"] = result["hydraulic"] * motorEfficiency / 100;

    return result;
  }*/


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
