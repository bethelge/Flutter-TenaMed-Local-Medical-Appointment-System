import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tena_med_flutter/features/appointment/presentation/screens/welcome_screen.dart';


void main() {
  runApp(const ProviderScope(child: TenaMedApp()));
}

class TenaMedApp extends StatelessWidget {
  const TenaMedApp({super.key});

  @override
  Widget build(BuildContext context) {
    final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const WelcomeScreen(),
    ),

  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TenaMed Home')),
      body: const Center(
        child: Text('Welcome to TenaMed 🚑'),
      ),
    );
  }
}
