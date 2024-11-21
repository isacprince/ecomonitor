import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';

class GoalScreen extends StatefulWidget {
  @override
  _GoalScreenState createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  TextEditingController goalController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final user = Provider.of<UserModel>(context, listen: false);
    goalController.text = user.weeklyGoal.toString();
  }

  void saveGoal() {
    final user = Provider.of<UserModel>(context, listen: false);
    double goal = double.tryParse(goalController.text) ?? 0.0;
    user.setWeeklyGoal(goal);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Definir Meta Semanal'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: goalController,
              decoration: InputDecoration(labelText: 'Meta de Consumo (Wh)'),
              keyboardType:
                  TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveGoal,
              child: Text('Salvar Meta'),
            ),
          ],
        ),
      ),
    );
  }
}
