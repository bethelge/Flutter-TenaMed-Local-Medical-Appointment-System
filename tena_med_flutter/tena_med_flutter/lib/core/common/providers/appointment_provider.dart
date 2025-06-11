import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../network/dio_client.dart'; // adjust the import if needed

final appointmentProvider = Provider<AppointmentService>((ref) {
  return AppointmentService();
});

class AppointmentService {
  final Dio _dio = DioClient.instance;
  // your Dio client from your network folder

  Future<int?> bookAppointment({
    required int patientId,
    required int doctorId,
    required String date,
    required String time,
    required String note,
  }) async {
    try {
      final response = await _dio.post('/appointments/book', data: {
        'patientId': patientId,
        'doctorId': doctorId,
        'date': date,
        'time': time,
        'note': note,
      });
      if (response.statusCode == 200) {
        // Assuming your API returns the appointment ID in response.data['appointmentId']
        return response.data['appointmentId'];
      }
    } catch (e) {
      print("Error booking appointment: $e");
    }
    return null;
  }
}
