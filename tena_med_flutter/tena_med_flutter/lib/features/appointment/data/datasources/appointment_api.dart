import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/appointment_model.dart';

class AppointmentApi {
  final String baseUrl;

  AppointmentApi({required this.baseUrl});

  Future<void> createAppointment(AppointmentModel appointment) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/appointments/book'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(appointment.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to create appointment: ${response.body}');
    }
  }

  Future<List<Future<List<AppointmentModel>>>> getAppointments(String patientId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/appointments/fetch?patientId=1'),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch appointments');
    }
    final List data = jsonDecode(response.body);
    return data.map((e) => AppointmentModel.fromJson(e)).toList();
  }

  Future<void> updateAppointment(AppointmentModel appointment) async {
    final response = await http.put(
      Uri.parse('$baseUrl/api/appointments/${appointment.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(appointment.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update appointment');
    }
  }

  Future<void> deleteAppointment(String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/localhost:5000/api/appointments/:14'),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete appointment');
    }
  }
}

mixin AppointmentModel {
  var id;

  static Future<List<AppointmentModel>> fromJson(e) {}

  Object? toJson() {}
}