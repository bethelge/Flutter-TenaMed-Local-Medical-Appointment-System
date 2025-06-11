import 'package:dio/dio.dart';
import 'doctor_auth_service.dart';

class DoctorAuthRepository {
  final DoctorAuthService _service;

  DoctorAuthRepository(this._service);

  Future<Response> registerDoctor(Map<String, dynamic> data) {
    return _service.registerDoctor(data);
  }

  Future<Response> loginDoctor(Map<String, dynamic> data) {
    return _service.loginDoctor(data);
  }
}