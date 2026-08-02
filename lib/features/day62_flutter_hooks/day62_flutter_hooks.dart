import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

const _accent = Color(0xFF6C5CE7);

class Day62FlutterHooks extends HookWidget {
  const Day62FlutterHooks({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    final obscurePassword = useState(true);
    final isLoggedIn = useState(false);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day 62 - Flutter Hooks',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .05),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Text(
                'flutter_hooks lets you use state, controllers, animations, and other reusable logic without creating a StatefulWidget or manually disposing resources.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.6,
                  color: Colors.black54,
                ),
              ),
            ),

            const SizedBox(height: 40), // was: const Spacer(),

            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'john@example.com',
                prefixIcon: const Icon(Icons.email_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),

            const SizedBox(height: 18),

            TextField(
              controller: passwordController,
              obscureText: obscurePassword.value,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  onPressed: () =>
                      obscurePassword.value = !obscurePassword.value,
                  icon: Icon(
                    obscurePassword.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),

            const SizedBox(height: 24),

            FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: _accent,
                minimumSize: const Size(double.infinity, 52),
              ),
              onPressed: () {
                isLoggedIn.value = true;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Welcome ${emailController.text}')),
                );
              },
              icon: const Icon(Icons.login),
              label: const Text('Login'),
            ),

            const SizedBox(height: 30),

            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: isLoggedIn.value
                    ? Colors.green.shade50
                    : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  Icon(
                    isLoggedIn.value
                        ? Icons.check_circle_rounded
                        : Icons.person_outline_rounded,
                    color: isLoggedIn.value ? Colors.green : _accent,
                    size: 56,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    isLoggedIn.value
                        ? 'Logged in successfully!'
                        : 'Waiting for login...',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: isLoggedIn.value ? Colors.green : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40), // was: const Spacer(),
          ],
        ),
      ),
    );
  }
}
