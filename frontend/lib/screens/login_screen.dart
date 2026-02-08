import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  final VoidCallback? onLoginSuccess;

  const LoginScreen({super.key, this.onLoginSuccess});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  String errorMessage = "";

  Future<void> login() async {
    setState(() {
      isLoading = true;
      errorMessage = "";
    });

    try {
      // ⚠️ Remplace l'URL par ton backend
      final response = await http.post(
        Uri.parse("http://192.168.100.237:5000/api/auth/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": emailController.text,
          "password": passwordController.text,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data["success"] == true) {
        widget.onLoginSuccess?.call();
      } else {
        setState(() {
          errorMessage = data["message"] ?? "Connexion échouée";
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "Erreur serveur";
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.local_pharmacy,
                  size: 80, color: Colors.green),
              const SizedBox(height: 20),

              const Text(
                "Connexion Pharmacien",
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 30),

              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 15),

              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Mot de passe",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              if (errorMessage.isNotEmpty)
                Text(errorMessage,
                    style: const TextStyle(color: Colors.red)),

              const SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: isLoading ? null : login,
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white)
                      : const Text("Se connecter",
                          style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
