import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'doctor_auth_service.dart';
import 'doctor_auth_repository.dart';

final doctorAuthRepositoryProvider = Provider<DoctorAuthRepository>((ref) {
  final service = DoctorAuthService();
  return DoctorAuthRepository(service);
});