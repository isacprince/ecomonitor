import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';

class ChallengesScreen extends StatelessWidget {
  final List<String> challenges = [
    'Reduza 10% do consumo nesta semana',
    'Use aparelhos fora do horário de pico',
    'Desligue aparelhos em stand-by',
  ];

  void completeChallenge(BuildContext context, int index) {
    Provider.of<UserModel>(context, listen: false).addPoints(10);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Desafio completado! +10 pontos')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userPoints = Provider.of<UserModel>(context).points;
    return Scaffold(
      appBar: AppBar(
        title: Text('Desafios'),
      ),
      body: ListView.builder(
        itemCount: challenges.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.flag),
            title: Text(challenges[index]),
            trailing: ElevatedButton(
              onPressed: () => completeChallenge(context, index),
              child: Text('Concluir'),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Seus pontos: $userPoints',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
