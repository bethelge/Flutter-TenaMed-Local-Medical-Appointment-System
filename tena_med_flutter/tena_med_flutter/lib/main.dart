import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tena_med_flutter/features/appointment/presentation/screens/welcome_screen.dart';

import 'features/appointment/presentation/screens/PatientLoginScreen.dart';
import 'features/appointment/presentation/screens/appointment_list_screen.dart';
import 'features/appointment/presentation/screens/book_appointment_screen.dart';
import 'features/appointment/presentation/screens/booking_succsess.dart';
import 'features/appointment/presentation/screens/doctor_appointment_detail.dart';
import 'features/appointment/presentation/screens/doctor_login_screen.dart';
import 'features/appointment/presentation/screens/doctor_profile_after_setup_screen.dart';
import 'features/appointment/presentation/screens/doctor_profile_setup_screen.dart';
import 'features/appointment/presentation/screens/doctor_signup_screen.dart';
import 'features/appointment/presentation/screens/patient_landing_screen.dart';
import 'features/appointment/presentation/screens/patient_signup_screen.dart';
import 'features/appointment/presentation/screens/post_booking_home_screen.dart';

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

        GoRoute(
          path: '/patient-login',
          builder: (context, state) => const PatientLoginScreen(),
        ),
        GoRoute(
          path: '/patient-signup',
          builder: (context, state) => const PatientSignupScreen(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const DoctorLoginScreen(),
        ),
        GoRoute(
          path: '/signup',
          builder: (context, state) => const DoctorSignupScreen(),
        ),
        GoRoute(
          path: '/post-booking-home',
          builder: (context, state) => const PostBookingHomeScreen(),
        ),
        GoRoute(
          path: '/doctor_profile_setup',
          builder: (context, state) => const DoctorProfileSetupScreen(),
        ),
        GoRoute(
          path: '/doctor_profile_after_setup',
          builder: (context, state) => const DoctorProfileAfterSetupScreen(),
        ),
        GoRoute(
          path: '/patient-landing',
          builder: (context, state) =>  PatientLandingScreen(),
        ),
        GoRoute(
          path: '/appointment-list',
          builder: (context, state) => const AppointmentListScreen(),
        ),
        GoRoute(
          path: '/book_appointment',
          builder: (context, state) => const BookAppointmentScreen(),
        ),
        GoRoute(
          path: '/success_screen',
          builder: (context, state) => const BookingSuccessScreen(),
        ),
        GoRoute(
          path: '/doctor_appointment_detail',
          builder: (context, state) => const DoctorAppointmentDetailScreen(),
        ),

      ],
    );


    return MaterialApp.router(
      title: 'TenaMed',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
      routerConfig: _router,

    );
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
