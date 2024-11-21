// lib/services/database_helper.dart

import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../models/appliance.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = '${documentsDirectory.path}/ecomonitor.db';
    return await openDatabase(
      path,
      version: 2, // Incrementar versão para adicionar nova tabela
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  // Criar as tabelas
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE appliances (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        power REAL NOT NULL,
        hoursPerDay REAL NOT NULL
      )
    ''');

    // Criação da tabela 'users'
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL
      )
    ''');
  }

  // Upgrade do banco de dados para adicionar novas tabelas ou campos
  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
        CREATE TABLE users (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          email TEXT NOT NULL UNIQUE,
          password TEXT NOT NULL
        )
      ''');
    }
  }

  // Inserir um aparelho
  Future<int> insertAppliance(Appliance appliance) async {
    Database db = await instance.database;
    return await db.insert('appliances', appliance.toMap());
  }

  // Obter todos os aparelhos
  Future<List<Appliance>> getAppliances() async {
    Database db = await instance.database;
    var appliances = await db.query('appliances', orderBy: 'id');
    List<Appliance> applianceList = appliances.isNotEmpty
        ? appliances.map((c) => Appliance.fromMap(c)).toList()
        : [];
    return applianceList;
  }

  // Atualizar um aparelho
  Future<int> updateAppliance(Appliance appliance) async {
    Database db = await instance.database;
    return await db.update('appliances', appliance.toMap(),
        where: 'id = ?', whereArgs: [appliance.id]);
  }

  // Deletar um aparelho
  Future<int> deleteAppliance(int id) async {
    Database db = await instance.database;
    return await db.delete('appliances', where: 'id = ?', whereArgs: [id]);
  }

  // Inserir um usuário
  Future<int> insertUser(Map<String, dynamic> user) async {
    Database db = await instance.database;
    return await db.insert('users', user);
  }

  // Obter um usuário por email e senha
  Future<Map<String, dynamic>?> getUser(String email, String password) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> results = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    if (results.isNotEmpty) {
      return results.first;
    }
    return null;
  }

  // Obter um usuário por email
  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> results = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    if (results.isNotEmpty) {
      return results.first;
    }
    return null;
  }
}
