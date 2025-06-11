import 'package:dio/dio.dart';
import '../../domain/entities/appointment.dart';

class AppointmentService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://your-api.com'));

  // Create Appointment
  Future<void> createAppointment(Appointment appointment) async {
    await _dio.post(
      '/appointments',
      data: appointment.toJson(),
    );
  }

  // Book Appointment (same as create, but you can change endpoint if needed)
  Future<void> bookAppointment(Appointment appointment) async {
    return createAppointment(appointment);
  }

  // Get all Appointments for a patient
  Future<List<Appointment>> getAppointments(String patientId) async {
    final response = await _dio.get('/appointments', queryParameters: {
      'patientId': patientId,
    });

    final data = response.data as List;
    return data.map((json) => Appointment.fromJson(json)).toList();
  }

  // Update Appointment
  Future<void> updateAppointment(Appointment appointment, Map<String, dynamic> json) async {
    await _dio.put(
      '/appointments/${appointment.id}',
      data: appointment.toJson(),
    );
  }

  // Delete Appointment
  Future<void> deleteAppointment(String id) async {
    await _dio.delete('/appointments/$id');
  }
}
