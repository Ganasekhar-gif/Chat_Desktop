// screens/auth/login_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/auth_service.dart';
import 'register_screen.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailCtrl = TextEditingController();
    final passCtrl = TextEditingController();

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 350,
          child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Welcome Back", 
                    style: Theme.of(context).textTheme.headlineSmall),

                  const SizedBox(height: 20),

                  TextField(
                    controller: emailCtrl,
                    decoration: const InputDecoration(
                      labelText: "Email",
                    ),
                  ),

                  const SizedBox(height: 10),

                  TextField(
                    controller: passCtrl,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Password",
                    ),
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () async {
                      try {
                        await ref.read(authServiceProvider).login(
                              email: emailCtrl.text.trim(),
                              password: passCtrl.text.trim(),
                            );
                      } catch (e) {
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Login failed: $e")),
                        );
                      }
                    },
                    child: const Text("Login"),
                  ),

                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const RegisterScreen()),
                      );
                    },
                    child: const Text("Create an Account"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
 
