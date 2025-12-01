// screens/auth/register_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/auth_service.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameCtrl = TextEditingController();
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
                  Text("Create Account",
                    style: Theme.of(context).textTheme.headlineSmall),

                  const SizedBox(height: 20),

                  TextField(
                    controller: nameCtrl,
                    decoration: const InputDecoration(labelText: "Name"),
                  ),
                  const SizedBox(height: 10),

                  TextField(
                    controller: emailCtrl,
                    decoration: const InputDecoration(labelText: "Email"),
                  ),
                  const SizedBox(height: 10),

                  TextField(
                    controller: passCtrl,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: "Password"),
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () async {
                      try {
                        await ref.read(authServiceProvider).register(
                              email: emailCtrl.text.trim(),
                              password: passCtrl.text.trim(),
                              name: nameCtrl.text.trim(),
                            );
                        if (!context.mounted) return;
                        Navigator.pop(context);
                      } catch (e) {
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Registration failed: $e")),
                        );
                      }
                    },
                    child: const Text("Sign Up"),
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
 
