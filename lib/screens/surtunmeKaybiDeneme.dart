import 'package:flutter/material.dart';
import 'dart:math' as math;

class MyPumpScreen extends StatefulWidget {
  @override
  _MyPumpScreenState createState() => _MyPumpScreenState();
}

class _MyPumpScreenState extends State<MyPumpScreen> {
  TextEditingController flowController = TextEditingController();
  TextEditingController powerController = TextEditingController();
  TextEditingController innerDiameterController = TextEditingController();
  TextEditingController kController = TextEditingController();
  TextEditingController lengthController = TextEditingController();
  TextEditingController temperatureController = TextEditingController();
  TextEditingController motorEfficiencyController = TextEditingController();
  TextEditingController waterLevelController = TextEditingController();
  TextEditingController pressureController = TextEditingController();
  TextEditingController exlossController = TextEditingController();

  Map<String, dynamic> result = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sürtünme Kaybı Hesaplama'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: flowController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Debi (flow)'),
              ),
              TextField(
                controller: powerController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Güç (power)'),
              ),
              TextField(
                controller: innerDiameterController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'İç Çap (innerDiameter)'),
              ),
              TextField(
                controller: kController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Boru Yüzeyi (k)'),
              ),
              TextField(
                controller: lengthController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Boru Uzunluğu (length)'),
              ),
              TextField(
                controller: temperatureController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Sıcaklık (temperature)'),
              ),
              TextField(
                controller: motorEfficiencyController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Motor Verimliliği (%) (motorEfficiency)'),
              ),
              TextField(
                controller: waterLevelController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Su Seviyesi (waterLevel)'),
              ),
              TextField(
                controller: pressureController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Basınç (pressure)'),
              ),
              TextField(
                controller: exlossController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Ek Kayıplar (exloss)'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Kullanıcıdan alınan değerleri kullanarak hesaplamaları yap
                  setState(() {
                    result = PumpEfficiency.calcYield(
                      double.parse(flowController.text),
                      double.parse(powerController.text),
                      double.parse(innerDiameterController.text),
                      double.parse(kController.text),
                      double.parse(lengthController.text),
                      double.parse(temperatureController.text),
                      double.parse(
                          motorEfficiencyController.text),
                      double.parse(waterLevelController.text),
                      double.parse(pressureController.text),
                      double.parse(exlossController.text),
                    );
                  });
                },
                child: Text('Hesapla'),
              ),





              SizedBox(height: 20),
              if (result.isNotEmpty)
                Text(
                    'Hesaplanan Verimlilik: ${result["system"] ?? "Hesaplanamadı"}'),
              // Diğer sonuçları da görüntüleyebilirsiniz.
            ],
          ),
        ),
      ),
    );
  }
}

class PumpEfficiency {
  static const vis = [
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

  static Map<String, dynamic> calcReynold(
      rho, u, innerDiameter, mu, vi) {
    Map<String, dynamic> result = {};
    double re = -1;

    if (rho != null && u != null && innerDiameter != null && mu != null && mu != 0) {
      re = (rho * u * innerDiameter / mu).round();
    }
    if (u != null && innerDiameter != null && vi != null) {
      re = (u * innerDiameter / vi);
    }

    if (re > 4000) {
      result["flow"] = "turbulans";
    }
    if (re > 2300 && re < 4000) {
      result["flow"] = "turbulans - laminer";
    }
    if (re < 2300) {
      result["flow"] = "laminer";
    }
    result["rn"] = re;

    return result;
  }

  static double frictionCoefficient(
      innerDiameter, k, re) {
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

  static double calcVis(t3) {
    if (t3 == null || t3 <= 0 || t3 > 100) {
      return 0;
    }

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

  static Map<String, dynamic> calcColebrook(
      innerDiameter, k, u, temperature) {
    Map<String, dynamic> result = {};
    result["vi"] = calcVis(temperature);

    Map<String, dynamic> rey = calcReynold(0, u, innerDiameter, 0, result["vi"]);
    result["ren"] = rey["rn"];
    result["fd"] = frictionCoefficient(innerDiameter, k, result["ren"]);
    result["rr"] = k / innerDiameter;

    result["turb"] = rey["flow"];
    return result;
  }

  static Map<String, dynamic> calcYield(
      flow,
      power,
      innerDiameter,
      k,
      l,
      temperature,
      motorEfficiency,
      waterLevel,
      pressure,
      exloss) {
    var a = math.pi * math.pow(innerDiameter, 2) / 4;

    var u = flow / 3600 / a;
    Map<String, dynamic> result = calcColebrook(innerDiameter, k, u, temperature);

    result["u"] = u;

    try {
      result["headLoss"] = (result["fd"] * l * math.pow(u, 2)) / (innerDiameter * (2 * 9.7905)) + exloss;
    } catch (_) {
      result["headLoss"] = exloss;
    }

    result["hm"] = (pressure * 10.197162 + waterLevel + result["headLoss"]);
    result["hydraulic"] = (result["hm"] * flow) / (367.2 * power * motorEfficiency / 10000);
    result["system"] = result["hydraulic"] * motorEfficiency / 100;

    return result;
  }
}
