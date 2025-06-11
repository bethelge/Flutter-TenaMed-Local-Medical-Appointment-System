import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/datasources/auth_providers.dart'; // <-- import your providers here
import '../../domain/entities/patient.dart';          // <-- import your Patient entity

class PatientSignupScreen extends ConsumerStatefulWidget {
  const PatientSignupScreen({super.key});

  @override
  ConsumerState<PatientSignupScreen> createState() => _PatientSignupScreenState();
}

class _PatientSignupScreenState extends ConsumerState<PatientSignupScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool passwordVisible = false;
  String errorMessage = '';
  bool isLoading = false;

  Future<void> signUp() async {
    setState(() {
      errorMessage = '';
      isLoading = true;
    });

    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (password != confirmPassword) {
      setState(() {
        errorMessage = "Passwords do not match";
        isLoading = false;
      });
      return;
    }

    try {
      final repo = ref.read(authRepositoryProvider);
      final patient = Patient(email: email, password: password, confirmPassword: '');
      await repo.signUpPatient(patient, confirmPassword);  // <-- pass confirmPassword here

      if (mounted) context.go('/patient-landing');
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Create your Account",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),

                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email address',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                TextField(
                  controller: passwordController,
                  obscureText: !passwordVisible,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        passwordVisible ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() => passwordVisible = !passwordVisible);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                TextField(
                  controller: confirmPasswordController,
                  obscureText: !passwordVisible,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        passwordVisible ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() => passwordVisible = !passwordVisible);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                ElevatedButton(
                  onPressed: isLoading ? null : signUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00BCD4),
                    minimumSize: const Size.fromHeight(48),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Sign Up"),
                ),

                if (errorMessage.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],

                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        context.go('/patient-login'); // Make sure route is defined
                      },
                      child: const Text("Log in"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
