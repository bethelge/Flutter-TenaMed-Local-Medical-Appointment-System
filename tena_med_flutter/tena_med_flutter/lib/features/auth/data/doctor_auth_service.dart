import 'package:dio/dio.dart';
// import 'package:tenamed/core/network/dio_client.dart';

import '../../../core/network/dio_client.dart';

class DoctorAuthService {
  final Dio _dio = DioClient.instance;

  Future<Response> registerDoctor(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/api/doctors/registerDoctor', data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> loginDoctor(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post('/api/doctors/login', data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}