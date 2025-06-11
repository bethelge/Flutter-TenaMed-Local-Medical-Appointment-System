import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/common/providers/message_provider.dart';
import '../../../../features/auth/presentation/doctor_auth_viewmodel.dart';
import 'doctor_profile_setup_screen.dart';

class DoctorSignupScreen extends ConsumerStatefulWidget {
  const DoctorSignupScreen({super.key});

  @override
  ConsumerState<DoctorSignupScreen> createState() => _DoctorSignupScreenState();
}

class _DoctorSignupScreenState extends ConsumerState<DoctorSignupScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(doctorAuthViewModelProvider).isLoading;
    final message = ref.watch(messageProvider);


    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text("Doctor Sign Up", style: TextStyle(fontSize: 24)),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) =>
                    value == null || value.isEmpty ? "Required" : null,
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Password'),
                    validator: (value) =>
                    value == null || value.length < 6 ? "Min 6 characters" : null,
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Confirm Password'),
                    validator: (value) =>
                    value != passwordController.text ? "Doesn't match" : null,
                  ),

                  if (message.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(message, style: const TextStyle(color: Colors.red)),
                    ),

                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () async {
                      if (_formKey.currentState!.validate()) {
                        final data = {
                          "email": emailController.text.trim(),
                          "password": passwordController.text,
                          "confirmPassword": confirmPasswordController.text,
                        };
                        final success = await ref
                            .read(doctorAuthViewModelProvider.notifier)
                            .registerDoctor(data);

                        if (success && mounted) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DoctorProfileSetupScreen(),
                            ),
                          );
                        }
                      }
                    },
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : const Text('Sign Up'),
                  ),


                  TextButton(
                    onPressed: () => context.go('/login'),
                    child: const Text("Already have an account? Log in"),
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