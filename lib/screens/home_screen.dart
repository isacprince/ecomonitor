// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../models/appliance.dart';
import '../services/database_helper.dart';
import 'appliance_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Appliance> appliances = [];
  double totalConsumption = 0.0;
  double totalSavings = 0.0;
  double goalProgress = 0.0;

  @override
  void initState() {
    super.initState();
    loadAppliances();
  }

  Future<void> loadAppliances() async {
    appliances = await DatabaseHelper.instance.getAppliances();
    calculateTotalConsumption();
    calculateTotalSavings();
    calculateGoalProgress();
    setState(() {});
  }

  void calculateTotalConsumption() {
    totalConsumption = appliances.fold(0.0, (sum, appliance) {
      return sum + (appliance.power * appliance.hoursPerDay);
    });
  }

  void calculateTotalSavings() {
    // Lógica fictícia para cálculo de economia
    // Por exemplo, suponha que o usuário economizou 10% em relação à semana anterior
    totalSavings = totalConsumption * 0.10;
  }

  void calculateGoalProgress() {
    final user = Provider.of<UserModel>(context, listen: false);
    if (user.weeklyGoal > 0) {
      goalProgress = (totalConsumption / user.weeklyGoal).clamp(0.0, 1.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserModel>(context);
    final userName = userModel.name ?? 'Usuário';

    return Scaffold(
      appBar: AppBar(
        title: Text('EcoMonitor'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ApplianceScreen(),
                ),
              ).then((value) => loadAppliances());
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Text('Bem-vindo, $userName!'), // Atualizado
              decoration: BoxDecoration(color: Colors.green),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Início'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.flag),
              title: Text('Desafios'),
              onTap: () {
                Navigator.pushNamed(context, '/challenges');
              },
            ),
            ListTile(
              leading: Icon(Icons.picture_as_pdf),
              title: Text('Relatórios'),
              onTap: () {
                Navigator.pushNamed(context, '/reports');
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Definir Meta'),
              onTap: () {
                Navigator.pushNamed(context, '/goal');
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Sair'),
              onTap: () {
                userModel.logout(); // Resetar informações do usuário
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: loadAppliances,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Seus Aparelhos',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              appliances.isEmpty
                  ? Text('Nenhum aparelho cadastrado.')
                  : Column(
                      children: appliances.map((appliance) {
                        return ListTile(
                          leading: Icon(Icons.electrical_services),
                          title: Text(appliance.name),
                          subtitle: Text(
                              'Potência: ${appliance.power}W, Uso Diário: ${appliance.hoursPerDay}h'),
                        );
                      }).toList(),
                    ),
              Divider(),
              SizedBox(height: 10),
              Text(
                'Relatório Semanal',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Card(
                color: Colors.green[50],
                child: ListTile(
                  leading: Icon(Icons.bar_chart, color: Colors.green),
                  title: Text('Consumo Total da Semana'),
                  subtitle: Text('${totalConsumption.toStringAsFixed(2)} Wh'),
                ),
              ),
              Card(
                color: Colors.lightGreen[50],
                child: ListTile(
                  leading: Icon(Icons.savings, color: Colors.green),
                  title: Text('Economia Nesta Semana'),
                  subtitle: Text('${totalSavings.toStringAsFixed(2)} Wh'),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Progresso da Meta Semanal',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              LinearProgressIndicator(
                value: goalProgress,
                backgroundColor: Colors.grey[300],
                color: Colors.green,
              ),
              SizedBox(height: 5),
              Text(
                '${(goalProgress * 100).toStringAsFixed(1)}% da meta atingida',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
