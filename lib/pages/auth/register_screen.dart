import 'package:flutter/material.dart';
import 'package:flutter_agus/services/auth_service.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Icon(Icons.person_add, size: 80, color: Colors.blue),
              const SizedBox(height: 24),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      : () async {
                          setState(() => _isLoading = true);

                          bool success = await _authService.register(
                            nameController.text,
                            emailController.text,
                            passwordController.text,
                          );

                          setState(() => _isLoading = false);

                          if (success) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const LoginScreen()),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Register gagal')),
                            );
                          }
                        },
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Register"),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // kembali ke login
                },
                child: const Text("Sudah punya akun? Login di sini"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
