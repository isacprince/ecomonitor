// lib/models/user.dart

import 'package:flutter/material.dart';
import '../services/database_helper.dart';

class UserModel extends ChangeNotifier {
  int points = 0;
  double weeklyGoal = 1000.0; // Valor padrão em Wh
  String? name;
  String? email;

  void addPoints(int value) {
    points += value;
    notifyListeners();
  }

  void setWeeklyGoal(double goal) {
    weeklyGoal = goal;
    notifyListeners();
  }

  // Método de registro
  Future<bool> register(String name, String email, String password) async {
    // Verificar se o email já está registrado
    var existingUser = await DatabaseHelper.instance.getUserByEmail(email);
    if (existingUser != null) {
      return false; // Usuário já existe
    }

    Map<String, dynamic> user = {
      'name': name,
      'email': email,
      'password': password,
    };
    await DatabaseHelper.instance.insertUser(user);
    this.name = name;
    this.email = email;
    notifyListeners();
    return true;
  }

  // Método de login
  Future<bool> login(String email, String password) async {
    var user = await DatabaseHelper.instance.getUser(email, password);
    if (user != null) {
      this.name = user['name'];
      this.email = user['email'];
      notifyListeners();
      return true;
    }
    return false; // Login falhou
  }

  // Método para logout
  void logout() {
    name = null;
    email = null;
    notifyListeners();
  }
}
