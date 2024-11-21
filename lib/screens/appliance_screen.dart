import 'package:flutter/material.dart';
import '../models/appliance.dart';
import '../services/database_helper.dart';

class ApplianceScreen extends StatefulWidget {
  @override
  _ApplianceScreenState createState() => _ApplianceScreenState();
}

class _ApplianceScreenState extends State<ApplianceScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  double _power = 0.0;
  double _hoursPerDay = 0.0;

  void _saveAppliance() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Appliance appliance = Appliance(
        name: _name,
        power: _power,
        hoursPerDay: _hoursPerDay,
      );
      await DatabaseHelper.instance.insertAppliance(appliance);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Adicionar Aparelho'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
              key: _formKey,
              child: Column(children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Nome do Aparelho'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o nome do aparelho';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _name = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Potência (W)'),
                  keyboardType:
                      TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira a potência do aparelho';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Por favor, insira um número válido';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _power = double.parse(value!);
                  },
                ),
                TextFormField(
                  decoration:
                      InputDecoration(labelText: 'Uso Diário (Horas)'),
                  keyboardType:
                      TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o uso diário do aparelho';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Por favor, insira um número válido';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _hoursPerDay = double.parse(value!);
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _saveAppliance,
                  child: Text('Salvar'),
                )
              ])),
        ));
  }
}
