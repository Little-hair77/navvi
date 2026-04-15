import 'package:flutter/material.dart';
import 'dart:async';
import 'home_screen.dart';

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

    Timer(const Duration(seconds: 2), () {
      setState(() => _isLoading = false);

      if (_emailController.text == "admin@navvi.com" && _senhaController.text == "123456") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const NavviApp()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Credenciais inválidas! Tente admin@navvi.com / 123456"),
            backgroundColor: Color(0xFF4A148C),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFFF3E5F5), // Roxo lavanda bem suave
              Colors.white,       // Branco puro
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.purple.withOpacity(0.1),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            )
                          ],
                        ),
                        child: const Icon(Icons.explore_rounded, size: 60, color: Color(0xFF4A148C)),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        "NAVVI",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 8,
                          color: Color(0xFF4A148C),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 60),
                
                const Text(
                  "Bem-vindo",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF2D2D2D)),
                ),
                const Text(
                  "Faça login para continuar explorando.",
                  style: TextStyle(fontSize: 15, color: Colors.blueGrey),
                ),
                const SizedBox(height: 40),

                _buildTextField(
                  controller: _emailController,
                  label: "E-mail",
                  icon: Icons.email_outlined,
                  obscure: false,
                ),
                const SizedBox(height: 20),

                _buildTextField(
                  controller: _senhaController,
                  label: "Senha",
                  icon: Icons.lock_outline_rounded,
                  obscure: true,
                ),
                
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Esqueceu a senha?", 
                      style: TextStyle(color: Color(0xFF8E24AA), fontWeight: FontWeight.w600)
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),

                Container(
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF8E24AA), Color(0xFF4A148C)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF4A148C).withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      )
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "ENTRAR",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                  ),
                ),
                
                const SizedBox(height: 40),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Ainda não tem uma conta? ", style: TextStyle(color: Colors.blueGrey)),
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          "Criar Conta",
                          style: TextStyle(color: Color(0xFF4A148C), fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required bool obscure,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8), 
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white), 
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: const TextStyle(color: Color(0xFF4A148C)),
        decoration: InputDecoration(
          hintText: label,
          hintStyle: TextStyle(color: Colors.grey.withOpacity(0.8)),
          prefixIcon: Icon(icon, color: const Color(0xFF4A148C), size: 22),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 18),
        ),
      ),
    );
  }
}