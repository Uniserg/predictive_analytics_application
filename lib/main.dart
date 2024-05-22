import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:predictive_analytics_application/data.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MaterialApp(home: MainApp()));
}

int getDevisions(int min, int max) {
  return max - min + 1;
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late final Car car;

  static const requiredField = "Обязательное поле";

  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    car = Car();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void getCarPrice(BuildContext context, Car car) async {
    showLoaderDialog(context);
    final response = await http.post(
      Uri.parse('http://192.168.229.19:5000/api/get-car-price'),
      headers: {
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': '*/*'
      },
      body: car.toJson(),
    );
    Navigator.pop(context);

    double? price;

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      price = double.parse(data['price']);
    } else {
      throw Exception(
          'Не удалось получить цену ${response.statusCode}: ${response.reasonPhrase}');
    }

    if (price == null) {
      throw Exception(
          'Не удалось получить цену ${response.statusCode}: ${response.reasonPhrase}');
    }

    setState(() {
      car.price = price!;
    });
  }

  @override
  Widget build(BuildContext context) {
    // double? dropdownSize = null;
    // double? titleSize = null;

    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  "Предиктивная система цены автомобилей",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              Center(
                child: Form(
                  key: _formKey,
                  child: Table(
                    textDirection: TextDirection.ltr,
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    columnWidths: const {
                      0: MaxColumnWidth(
                          FractionColumnWidth(0.2), IntrinsicColumnWidth()),
                      1: MaxColumnWidth(
                          FractionColumnWidth(0.7), IntrinsicColumnWidth()),
                    },
                    children: [
                      TableRow(
                        children: [
                          const Text("Бренд:"),
                          DropdownButtonFormField<Brand>(
                              validator: (value) =>
                                  value != null ? null : requiredField,
                              isExpanded: true,
                              value: car.brand,
                              items: Brand.values
                                  .map((e) => DropdownMenuItem<Brand>(
                                        value: e,
                                        child: Text(e.name),
                                      ))
                                  .toList(),
                              onChanged: (brand) {
                                if (brand == car.brand) return;
                                setState(() {
                                  car.brand = brand;
                                  car.model = null;
                                });
                              })
                        ],
                      ),
                      TableRow(
                        children: [
                          const Text("Модель:"),
                          DropdownButtonFormField<String>(
                              validator: (value) =>
                                  value != null ? null : requiredField,
                              isExpanded: true,
                              value: car.model,
                              items: car.brand?.index != null
                                  ? models[Brand.values[car.brand!.index].name]
                                      ?.map((e) => DropdownMenuItem<String>(
                                            value: e,
                                            child: Text(e),
                                          ))
                                      .toList()
                                  : [],
                              onChanged: (model) {
                                setState(() {
                                  car.model = model;
                                });
                              }),
                        ],
                      ),
                      TableRow(
                        children: [
                          const Text("Тип транспорта:"),
                          DropdownButtonFormField<VehicleType>(
                              validator: (value) =>
                                  value != null ? null : requiredField,
                              isExpanded: true,
                              value: car.vehicleType,
                              items: VehicleType.values
                                  .map((e) => DropdownMenuItem<VehicleType>(
                                        value: e,
                                        child: Text(e.name),
                                      ))
                                  .toList(),
                              onChanged: (vehicleType) {
                                setState(() {
                                  car.vehicleType = vehicleType;
                                });
                              })
                        ],
                      ),
                      TableRow(
                        children: [
                          const Text("Тип топлива:"),
                          DropdownButtonFormField<FuelType>(
                              validator: (value) =>
                                  value != null ? null : requiredField,
                              isExpanded: true,
                              value: car.fuelType,
                              items: FuelType.values
                                  .map((e) => DropdownMenuItem<FuelType>(
                                        value: e,
                                        child: Text(e.name),
                                      ))
                                  .toList(),
                              onChanged: (fuelType) {
                                setState(() {
                                  car.fuelType = fuelType;
                                });
                              }),
                        ],
                      ),
                      TableRow(
                        children: [
                          const Text("Коробка передач:"),
                          DropdownButtonFormField<Gearbox>(
                              validator: (value) =>
                                  value != null ? null : requiredField,
                              isExpanded: true,
                              value: car.gearbox,
                              items: Gearbox.values
                                  .map((e) => DropdownMenuItem<Gearbox>(
                                        value: e,
                                        child: Text(e.name),
                                      ))
                                  .toList(),
                              onChanged: (gearbox) {
                                setState(() {
                                  car.gearbox = gearbox;
                                });
                              }),
                        ],
                      ),
                      TableRow(
                        children: [
                          const Text("Мощность двигателя, л.с.:"),
                          Row(
                            children: [
                              Expanded(
                                child: Slider(
                                  value: car.powerPS?.toDouble() ?? 50,
                                  min: 50,
                                  max: 2500,
                                  divisions: getDevisions(50, 2500) * 10,
                                  label:
                                      car.powerPS?.toStringAsFixed(1) ?? '50',
                                  onChanged: (double value) {
                                    setState(() {
                                      car.powerPS = value;
                                    });
                                  },
                                ),
                              ),
                              Text(car.powerPS
                                      ?.toStringAsFixed(1)
                                      .padLeft(6, '0') ??
                                  '50.0'.padLeft(6, '0')),
                            ],
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          const Text("Год выпуска"),
                          Row(
                            children: [
                              Expanded(
                                child: Slider(
                                  value:
                                      car.yearRegistration?.toDouble() ?? 1970,
                                  min: 1970,
                                  max: 2024,
                                  divisions: getDevisions(1970, 2024),
                                  // divisions: 5,
                                  label: car.yearRegistration?.toString() ??
                                      '1970',
                                  onChanged: (double value) {
                                    setState(() {
                                      car.yearRegistration = value.toInt();
                                    });
                                  },
                                ),
                              ),
                              Text(car.yearRegistration?.toString() ?? '1970')
                            ],
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          const Text("Пробег"),
                          Row(
                            children: [
                              Expanded(
                                child: Slider(
                                  value: car.kilometer ?? 0,
                                  min: 0,
                                  max: 100000,
                                  divisions: 1000000,
                                  label:
                                      car.kilometer?.toStringAsFixed(1) ?? '0',
                                  onChanged: (double value) {
                                    setState(() {
                                      car.kilometer = value;
                                    });
                                  },
                                ),
                              ),
                              Text(car.kilometer
                                      ?.toStringAsFixed(1)
                                      .padLeft(8, "0") ??
                                  '0.0'.padRight(8, '0'))
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentContext != null &&
                          _formKey.currentState!.validate()) {
                        getCarPrice(context, car);
                      }
                    },
                    child: const Text("Рассчитать стоимость")),
              ),
              if (car.price != null)
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          child: Text(
                        "Цена вашего авто = ${car.price}",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
