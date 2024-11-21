// lib/screens/login_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController(); // Novo
  final _formKey = GlobalKey<FormState>(); // Para validação do formulário

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      final userModel = Provider.of<UserModel>(context, listen: false);
      bool success = await userModel.login(emailController.text, passwordController.text);
      if (success) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        // Mostrar erro de login
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Email ou senha inválidos')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SingleChildScrollView( // Adicionado para tornar a tela rolável
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form( // Usar Form para validação
            key: _formKey,
            child: Column(
              children: [
                // Adicionando a logo
                Image.asset(
                  'assets/images/logo.png',
                  height: 150, // Ajuste a altura conforme necessário
                ),
                SizedBox(height: 20), // Espaçamento entre a logo e os campos
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu email';
                    }
                    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                      return 'Por favor, insira um email válido';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: passwordController, // Novo
                  decoration: InputDecoration(labelText: 'Senha'),
                  obscureText: true, // Para ocultar a senha
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira sua senha';
                    }
                    if (value.length < 6) {
                      return 'A senha deve ter pelo menos 6 caracteres';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _handleLogin,
                  child: Text('Entrar'),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register'); // Navegar para a tela de registro
                  },
                  child: Text('Não tem uma conta? Registre-se'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
