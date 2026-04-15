import 'package:flutter/material.dart';
import 'dart:async';

import 'package:navvi/home_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  bool _isLoading = false;

  void _login() {
    setState(() => _isLoading = true);

    // Simulação de um delay de rede
    Timer(const Duration(seconds: 2), () {
      setState(() => _isLoading = false);

      if (_emailController.text == "admin@navvi.com" && _senhaController.text == "123456") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const NavviApp(),
          )
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Credenciais inválidas! Tenta admin@navvi.com / 123456"),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF3E5F5), Colors.white], // Roxo muito claro para branco
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo ou Ícone
              const SizedBox(height: 10),
              const Text(
                "NAVVI",
                style: TextStyle(
                  fontFamily: 'Georgia',
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 5,
                  color: Color(0xFF4A148C),
                ),
              ),
              const Text("O teu guia de bolso", style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 50),

              // Campo de Email
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "E-mail",
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                ),
              ),
              const SizedBox(height: 20),

              // Campo de Senha
              TextField(
                controller: _senhaController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Senha",
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                ),
              ),
              const SizedBox(height: 30),

              // Botão Entrar
              GestureDetector(
                onTap: _isLoading ? null : _login,
                child: Container(
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF8E24AA), Color(0xFF4A148C)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      )
                    ],
                  ),
                  child: Center(
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "ENTRAR",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}