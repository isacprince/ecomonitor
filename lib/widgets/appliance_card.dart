import 'package:flutter/material.dart';
import '../models/appliance.dart';

class ApplianceCard extends StatelessWidget {
  final Appliance appliance;
  final VoidCallback onDelete;

  ApplianceCard({required this.appliance, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.electrical_services),
        title: Text(appliance.name),
        subtitle: Text(
            'Potência: ${appliance.power}W, Uso Diário: ${appliance.hoursPerDay}h'),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
