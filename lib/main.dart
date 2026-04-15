import 'package:flutter/material.dart';
import 'login_screen.dart'; // Importa a sua nova tela de login
import 'home_screen.dart';  // Importa a home (onde está a classe NavviApp)

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false, // Remove a faixa de debug
    home: LoginScreen(), // Define que o app SEMPRE começa pelo Login
  ));
}