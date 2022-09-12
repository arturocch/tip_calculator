// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_element

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // TODO: completar todo lo necesario
  int? currentRadio;
  bool isSwitched = false;
  double tip = 0.0;
  TextEditingController service = TextEditingController();
  var radioGroup = {
    0: "Amazing (20%)",
    1: "Good (18%)",
    2: "Okay (15%)",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 30, 170, 102),
        title: Text('Tip time'),
      ),
      body: ListView(
        children: [
          SizedBox(height: 14),
          ListTile(
            leading: Icon(Icons.room_service),
            title: Padding(
              padding: EdgeInsets.only(right: 24),
              child: TextFormField(
                controller: service,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                  label: Text('cost of service'),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.dinner_dining),
            title: Text("How was the service?"),
          ),
          Column(children: radioGenerator()),
          ListTile(
            leading: Icon(Icons.credit_card),
            title: Text("Round up tip"),
            trailing: Switch(
              value: isSwitched,
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                });
              },
            ),
          ),
          MaterialButton(
            child: Text("CALCULATE"),
            textColor: Colors.white,
            color: Colors.green,
            onPressed: () {
              _tipCalculation();
              setState(() {});
            },
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text("Tip amount:  ${tip}", textAlign: TextAlign.end),
          )
        ],
      ),
    );
  }

  void _tipCalculation() {
    // TODO: completar
    double? service_d = double.tryParse(service.text);
    if (service_d == null) {
      return;
    }
    if (currentRadio == 0) {
      tip = service_d * 0.20;
    } else if (currentRadio == 1) {
      tip = service_d * 0.18;
    } else if (currentRadio == 2) {
      tip = service_d * 0.15;
    }

    if (isSwitched) {
      tip = tip.ceilToDouble();
    }
  }

  radioGenerator() {
    return radioGroup.entries
        .map(
          (radioElement) => ListTile(
            leading: Radio(
                value: radioElement.key,
                groupValue: currentRadio,
                onChanged: (int? newValue) {
                  currentRadio = newValue;
                  setState(() {});
                }),
            title: Text(radioElement.value),
          ),
        )
        .toList();
  }
}
