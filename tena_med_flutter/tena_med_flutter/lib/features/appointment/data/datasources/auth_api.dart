import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/patient_model.dart';
import '../models/doctor_model.dart'; // <-- Add this

class AuthApi {
  final String baseUrl;

  AuthApi({required this.baseUrl});

  Future<void> signUpPatient(Patient patient, String confirmPassword) async {
    final body = {
      'email': patient.email,
      'password': patient.password,
      'confirmPassword': confirmPassword,
    };

    final response = await http.post(
      Uri.parse('$baseUrl/api/patients/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to sign up: ${response.body}');
    }
  }

  Future<void> signUpDoctor(DoctorModel doctor, String confirmPassword) async {
    final body = {
      'email': doctor.email,
      'password': doctor.password,
      'confirmPassword': confirmPassword,
    };

    final response = await http.post(
      Uri.parse('$baseUrl/api/doctors/registerDoctor'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to sign up doctor: ${response.body}');
    }
  }
  Future<void> loginPatient(String email, String password) async {
    final body = {'email': email, 'password': password};

    final response = await http.post(
      Uri.parse('$baseUrl/api/patients/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to login patient: ${response.body}');
    }

    // Optionally, handle response data (e.g., tokens) here
  }
  Future<void> loginDoctor(String email, String password) async {
    final body = {'email': email, 'password': password};

    final response = await http.post(
      Uri.parse('$baseUrl/api/doctors/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to login doctor: ${response.body}');
    }

    // Optionally, handle tokens or response data here
  }

}
