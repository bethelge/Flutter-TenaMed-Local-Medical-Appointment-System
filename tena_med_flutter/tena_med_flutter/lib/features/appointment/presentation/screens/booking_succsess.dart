import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BookingSuccessScreen extends StatelessWidget {
  const BookingSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.thumb_up,
                color: const Color(0xFF00BCD4),
                size: 72,
              ),
              const SizedBox(height: 24),
              const Text(
                'Successfully sent a request',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Dr. Doc Doc will receive a notification',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  context.go('/post-booking-home');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00BCD4),
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text('OK'),
              )
            ],
          ),
        ),
      ),
    );
  }
}