import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/appliance_screen.dart';
import 'screens/challenges_screen.dart';
import 'screens/reports_screen.dart';
import 'screens/goal_screen.dart';
import 'services/database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.database;
  runApp(EcoMonitorApp());
}

class EcoMonitorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserModel>(
      create: (_) => UserModel(),
      child: MaterialApp(
        title: 'EcoMonitor',
        theme: ThemeData(
          primarySwatch: Colors.green,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.green,
          ).copyWith(
            secondary: Colors.lightGreen,
          ),
          fontFamily: 'Roboto',
          textTheme: TextTheme(
            bodyLarge: TextStyle(color: Colors.black87),
            bodyMedium: TextStyle(color: Colors.black54),
          ),
        ),
        home: SplashScreen(),
        routes: {
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
          '/home': (context) => HomeScreen(),
          '/appliances': (context) => ApplianceScreen(),
          '/challenges': (context) => ChallengesScreen(),
          '/reports': (context) => ReportsScreen(),
          '/goal': (context) => GoalScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
